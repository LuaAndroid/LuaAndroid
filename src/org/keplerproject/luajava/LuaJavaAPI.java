/*
 * $Id: LuaJavaAPI.java,v 1.4 2006/12/22 14:06:40 thiago Exp $
 * Copyright (C) 2003-2007 Kepler Project.
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
 * CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
 * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
 * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

package org.keplerproject.luajava;

import java.lang.reflect.Constructor;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;

/**
 * Class that contains functions accessed by lua.
 * 
 * @author Thiago Ponte
 */
public final class LuaJavaAPI
{

  private LuaJavaAPI()
  {
  }

  /**
   * Java implementation of the metamethod __index
   * 
   * @param luaState int that indicates the state used
   * @param obj Object to be indexed
   * @param methodName the name of the method
   * @return number of returned objects
   */
  public static int objectIndex(int luaState, Object obj, String methodName)
      throws LuaException
  {
    LuaState L = LuaStateFactory.getExistingState(luaState);

    synchronized (L)
    {
      int top = L.getTop();

      Object[] objs = new Object[top - 1];

      Class clazz;

      if (obj instanceof Class)
      {
        clazz = (Class) obj;
      }
      else
      {
        clazz = obj.getClass();
      }

      Method[] methods = clazz.getMethods();
      Method method = null;

      // gets method and arguments
      for (int i = 0; i < methods.length; i++)
      {
        if (!methods[i].getName().equals(methodName))

          continue;

        Class[] parameters = methods[i].getParameterTypes();
        if (parameters.length != top - 1)
          continue;

        boolean okMethod = true;

        for (int j = 0; j < parameters.length; j++)
        {
          try
          {
            objs[j] = compareTypes(L, parameters[j], j + 2);
          }
          catch (Exception e)
          {
            okMethod = false;
            break;
          }
        }

        if (okMethod)
        {
          method = methods[i];
          break;
        }

      }

      // If method is null means there isn't one receiving the given arguments
      if (method == null)
      {
        throw new LuaException("Invalid method call. No such method.");
      }

      Object ret;
      try
      {
        if(Modifier.isPublic(method.getModifiers()))
        {
          method.setAccessible(true);
        }
        
        if (obj instanceof Class)
        {
          ret = method.invoke(null, objs);
        }
        else
        {
          ret = method.invoke(obj, objs);
        }
      }
      catch (Exception e)
      {
        throw new LuaException(e);
      }

      // Void function returns null
      if (ret == null)
      {
        return 0;
      }

      // push result
      L.pushObjectValue(ret);

      return 1;
    }
  }

  /**
   * Java function to be called when a java Class metamethod __index is called.
   * This function returns 1 if there is a field with searchName and 2 if there
   * is a method if the searchName
   * 
   * @param luaState int that represents the state to be used
   * @param clazz class to be indexed
   * @param searchName name of the field or method to be accessed
   * @return number of returned objects
   * @throws LuaException
   */
  public static int classIndex(int luaState, Class clazz, String searchName)
      throws LuaException
  {
    synchronized (LuaStateFactory.getExistingState(luaState))
    {
      int res;

      res = checkField(luaState, clazz, searchName);

      if (res != 0)
      {
        return 1;
      }

      res = checkMethod(luaState, clazz, searchName);

      if (res != 0)
      {
        return 2;
      }

      return 0;
    }
  }

  /**
   * Pushes a new instance of a java Object of the type className
   * 
   * @param luaState int that represents the state to be used
   * @param className name of the class
   * @return number of returned objects
   * @throws LuaException
   */
  public static int javaNewInstance(int luaState, String className)
      throws LuaException
  {
    LuaState L = LuaStateFactory.getExistingState(luaState);

    synchronized (L)
    {
      Class clazz;
      try
      {
        clazz = Class.forName(className);
      }
      catch (ClassNotFoundException e)
      {
        throw new LuaException(e);
      }
      Object ret = getObjInstance(L, clazz);

      L.pushJavaObject(ret);

      return 1;
    }
  }

  /**
   * javaNew returns a new instance of a given clazz
   * 
   * @param luaState int that represents the state to be used
   * @param clazz class to be instanciated
   * @return number of returned objects
   * @throws LuaException
   */
  public static int javaNew(int luaState, Class clazz) throws LuaException
  {
    LuaState L = LuaStateFactory.getExistingState(luaState);

    synchronized (L)
    {
      Object ret = getObjInstance(L, clazz);

      L.pushJavaObject(ret);

      return 1;
    }
  }

  /**
   * Calls the static method <code>methodName</code> in class <code>className</code>
   * that receives a LuaState as first parameter.
   * @param luaState int that represents the state to be used
   * @param className name of the class that has the open library method
   * @param methodName method to open library
   * @return number of returned objects
   * @throws LuaException
   */
  public static int javaLoadLib(int luaState, String className, String methodName)
  	throws LuaException
  {
    LuaState L = LuaStateFactory.getExistingState(luaState);
    
    synchronized (L)
    {
      Class clazz;
      try
      {
        clazz = Class.forName(className);
      }
      catch (ClassNotFoundException e)
      {
        throw new LuaException(e);
      }

      try
      {
        Method mt = clazz.getMethod(methodName, new Class[] {LuaState.class});
        Object obj = mt.invoke(null, new Object[] {L});
        
        if (obj != null && obj instanceof Integer)
        {
          return ((Integer) obj).intValue();
        }
        else
          return 0;
      }
      catch (Exception e)
      {
        throw new LuaException("Error on calling method. Library could not be loaded. " + e.getMessage());
      }
    }
  }

  private static Object getObjInstance(LuaState L, Class clazz)
      throws LuaException
  {
    synchronized (L)
    {
	    int top = L.getTop();
	
	    Object[] objs = new Object[top - 1];
	
	    Constructor[] constructors = clazz.getConstructors();
	    Constructor constructor = null;
	
	    // gets method and arguments
	    for (int i = 0; i < constructors.length; i++)
	    {
	      Class[] parameters = constructors[i].getParameterTypes();
	      if (parameters.length != top - 1)
	        continue;
	
	      boolean okConstruc = true;
	
	      for (int j = 0; j < parameters.length; j++)
	      {
	        try
	        {
	          objs[j] = compareTypes(L, parameters[j], j + 2);
	        }
	        catch (Exception e)
	        {
	          okConstruc = false;
	          break;
	        }
	      }
	
	      if (okConstruc)
	      {
	        constructor = constructors[i];
	        break;
	      }
	
	    }
	
	    // If method is null means there isn't one receiving the given arguments
	    if (constructor == null)
	    {
	      throw new LuaException("Invalid method call. No such method.");
	    }
	
	    Object ret;
	    try
	    {
	      ret = constructor.newInstance(objs);
	    }
	    catch (Exception e)
	    {
	      throw new LuaException(e);
	    }
	
	    if (ret == null)
	    {
	      throw new LuaException("Couldn't instantiate java Object");
	    }
	
	    return ret;
    }
  }

  /**
   * Checks if there is a field on the obj with the given name
   * 
   * @param luaState int that represents the state to be used
   * @param obj object to be inspected
   * @param fieldName name of the field to be inpected
   * @return number of returned objects
   */
  public static int checkField(int luaState, Object obj, String fieldName)
  	throws LuaException
  {
    LuaState L = LuaStateFactory.getExistingState(luaState);

    synchronized (L)
    {
      Field field = null;
      Class objClass;

      if (obj instanceof Class)
      {
        objClass = (Class) obj;
      }
      else
      {
        objClass = obj.getClass();
      }

      try
      {
        field = objClass.getField(fieldName);
      }
      catch (Exception e)
      {
        return 0;
      }

      if (field == null)
      {
        return 0;
      }

      Object ret = null;
      try
      {
        ret = field.get(obj);
      }
      catch (Exception e1)
      {
        return 0;
      }

      if (obj == null)
      {
        return 0;
      }

      L.pushObjectValue(ret);

      return 1;
    }
  }

  //--Start vitonzhang 2016-04-11
  /**
   * Set the value of instance's field.  
   * 
   * @param luaState int that represents the state to be used
   * @param obj object whose property will be changed
   * @param fieldName name of the field whose value be changed 
   * @param value new value for the field 
   * @return number of returned objects
   **/
  public static int setField(int luaState, Object obj, String fieldName, Object value) 
  {
	  LuaState L = LuaStateFactory.getExistingState(luaState);
	  
	  synchronized (L)
	  {
		  
		  Class clazz;
		  Field field = null;
		  
		  if (obj instanceof Class)
		  {
			  clazz = (Class) obj;
		  }
		  else
		  {
			  clazz = obj.getClass();
		  }
		  
		  // Get the field.
		  try 
		  {
			  field = clazz.getField(fieldName);
		  }
		  catch (Exception e)
		  {
			  return 0;
		  }
		  
		  if (field == null)
		  {
			  return 0;
		  }
		  
		  try 
		  {
			  Class fieldClazz = field.getType();
			  
			  if (fieldClazz.isPrimitive() && value instanceof Double) // Primitive Type
			  {
				  // int i = 0;
				  
				  // Primitive Type
				  // https://docs.oracle.com/javase/tutorial/java/nutsandbolts/datatypes.html
				  
				  Double valueObj = (Double)value;
				 
				  if (fieldClazz.equals(byte.class))
				  {
					  // i = 1;
					  field.setByte(obj, valueObj.byteValue());
				  }
				  else if (fieldClazz.equals(short.class))
				  {
					  // i = 2;
					  field.setShort(obj, valueObj.shortValue());
				  }
				  else if (fieldClazz.equals(int.class)) 
				  {
					  // i = 3;
					  field.setInt(obj, valueObj.intValue());
				  }
				  else if (fieldClazz.equals(long.class)) 
				  {
					  // i = 4;
					  field.setLong(obj, valueObj.longValue());
				  }
				  else if (fieldClazz.equals(float.class)) 
				  {
					  // i = 5;
					  field.setFloat(obj, valueObj.floatValue());
				  }
				  else if (fieldClazz.equals(double.class))
				  {
					  // i = 6;
					  field.setDouble(obj, valueObj.doubleValue());
				  }
				  else if (fieldClazz.equals(boolean.class))
				  {
					  // i = 7;
					  int intValue = valueObj.intValue();
					  boolean boolValue = intValue == 1 ? true : false;
					  field.setBoolean(obj, boolValue);
				  }
			  }
			  // Set value of the property which is char type.
			  else if (fieldClazz.equals(char.class) && value instanceof String)
			  {
				  String stringValue = (String)value;
				  char charValue = stringValue.charAt(0);
				  field.setChar(obj, charValue);
			  }
			  // Set value of the property which is boolean type via 'true' or 'false' in lua.
			  else if (fieldClazz.equals(boolean.class) && value instanceof Boolean)
			  {
				  Boolean boolObj = (Boolean)value;
				  field.setBoolean(obj, boolObj.booleanValue());
			  }
			  else // Reference Type
			  {
				  field.set(obj, value);
			  }
		  }
		  catch (IllegalAccessException e)
		  {
			  return 0;
		  }
		  catch (IllegalArgumentException e) 
		  {
			  return 0;
		  }
	  }
	  
	  return 0;
  }
//--End vitonzhang 2016-04-11
  
  /**
   * Checks to see if there is a method with the given name.
   * 
   * @param luaState int that represents the state to be used
   * @param obj object to be inspected
   * @param methodName name of the field to be inpected
   * @return number of returned objects
   */
  public static int checkMethod(int luaState, Object obj, String methodName)
  {
    LuaState L = LuaStateFactory.getExistingState(luaState);

    synchronized (L)
    {
      Class clazz;

      if (obj instanceof Class)
      {
        clazz = (Class) obj;
      }
      else
      {
        clazz = obj.getClass();
      }

      Method[] methods = clazz.getMethods();

      for (int i = 0; i < methods.length; i++)
      {
        if (methods[i].getName().equals(methodName))
          return 1;
      }

      return 0;
    }
  }

  /**
   * Function that creates an object proxy and pushes it into the stack
   * 
   * @param luaState int that represents the state to be used
   * @param implem interfaces implemented separated by comma (<code>,</code>)
   * @return number of returned objects
   * @throws LuaException
   */
  public static int createProxyObject(int luaState, String implem)
    throws LuaException
  {
    LuaState L = LuaStateFactory.getExistingState(luaState);

    synchronized (L)
    {
      try
      {
        if (!(L.isTable(2)))
          throw new LuaException(
              "Parameter is not a table. Can't create proxy.");

        LuaObject luaObj = L.getLuaObject(2);

        Object proxy = luaObj.createProxy(implem);
        L.pushJavaObject(proxy);
      }
      catch (Exception e)
      {
        throw new LuaException(e);
      }

      return 1;
    }
  }

  private static Object compareTypes(LuaState L, Class parameter, int idx)
    throws LuaException
  {
    boolean okType = true;
    Object obj = null;

    if (L.isBoolean(idx))
    {
      if (parameter.isPrimitive())
      {
        if (parameter != Boolean.TYPE)
        {
          okType = false;
        }
      }
      else if (!parameter.isAssignableFrom(Boolean.class))
      {
        okType = false;
      }
      obj = new Boolean(L.toBoolean(idx));
    }
    else if (L.type(idx) == LuaState.LUA_TSTRING.intValue())
    {
      if (!parameter.isAssignableFrom(String.class))
      {
        okType = false;
      }
      else
      {
        obj = L.toString(idx);
      }
    }
    else if (L.isFunction(idx))
    {
      if (!parameter.isAssignableFrom(LuaObject.class))
      {
        okType = false;
      }
      else
      {
        obj = L.getLuaObject(idx);
      }
    }
    else if (L.isTable(idx))
    {
      if (!parameter.isAssignableFrom(LuaObject.class))
      {
        okType = false;
      }
      else
      {
        obj = L.getLuaObject(idx);
      }
    }
    else if (L.type(idx) == LuaState.LUA_TNUMBER.intValue())
    {
      Double db = new Double(L.toNumber(idx));
      
      obj = LuaState.convertLuaNumber(db, parameter);
      if (obj == null)
      {
        okType = false;
      }
    }
    else if (L.isUserdata(idx))
    {
      if (L.isObject(idx))
      {
        Object userObj = L.getObjectFromUserdata(idx);
        if (!parameter.isAssignableFrom(userObj.getClass()))
        {
          okType = false;
        }
        else
        {
          obj = userObj;
        }
      }
      else
      {
        if (!parameter.isAssignableFrom(LuaObject.class))
        {
          okType = false;
        }
        else
        {
          obj = L.getLuaObject(idx);
        }
      }
    }
    else if (L.isNil(idx))
    {
      obj = null;
    }
    else
    {
      throw new LuaException("Invalid Parameters.");
    }

    if (!okType)
    {
      throw new LuaException("Invalid Parameter.");
    }

    return obj;
  }

}