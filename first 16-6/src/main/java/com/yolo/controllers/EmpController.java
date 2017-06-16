package com.yolo.controllers;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;

import org.reflections.Reflections;
import org.reflections.scanners.ResourcesScanner;
import org.reflections.scanners.SubTypesScanner;
import org.reflections.util.ClasspathHelper;
import org.reflections.util.ConfigurationBuilder;
import org.reflections.util.FilterBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.yolo.beans.*;
import com.yolo.dao.*;
import com.google.gson.Gson;

import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class EmpController {

	@Autowired
	EmpDao dao;// will inject dao from xml file

	// PlayDao playdao;

	@RequestMapping(value = "/QueryBuilder", method = RequestMethod.GET)
	public ModelAndView QueryBuild() {
		List emplist = dao.listEmp();
		// List<Player> playerlist=playdao.listPlayer();

		List<String> classes = getClasses("com.yolo.beans");
		System.out.println(classes.toString());

		// System.out.print(list);
		ModelAndView mv = new ModelAndView("QueryBuilder");
		mv.addObject("emplist", emplist);
		// mv.addObject("playerlist",playerlist);
		mv.addObject("classes", classes);
		return mv;

	}

	@RequestMapping(value = "/try1", method = RequestMethod.POST)
	public ModelAndView try1(@RequestParam("entity") String entity) {
		Class<?> clazz;
		Object obj = new Object();

		// System.out.println(entity);
		try {
			clazz = Class.forName("com.yolo.beans." + entity);
			obj = clazz.newInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}

		Field[] fields = (obj).getClass().getDeclaredFields();
		List<String> vars = new ArrayList<String>();

		for (Field f : fields) {
			vars.add(f.getName());
		}
		Gson gson = new Gson();
		// convert your list to json
		String deplist = gson.toJson(vars);
		System.out.println(deplist);
		return new ModelAndView("try1", "deplist", deplist);
	}

	@RequestMapping(value = "/fetchTable", method = RequestMethod.POST)
	public ModelAndView fetchTable(@RequestParam("query") String query) {

		List result = dao.customQuery(query);

		Gson gson = new Gson();
		// convert your list to json

		String resultGson = gson.toJson(result);
		System.out.println(resultGson + " checkkkkkkkkkkkkkkkkkkkkkkkkkkkk");

		ModelAndView mv = new ModelAndView("fetchTable");
		mv.addObject("resultGson", resultGson);
		return mv;
	}

	@RequestMapping(value = "/sudQuery", method = RequestMethod.POST)
	public ModelAndView sudQuery(@RequestParam("name") String name,
			@RequestParam("query") String query,
			@RequestParam("type") String type,
			@RequestParam("new_name") String new_name) {

		ModelAndView mv = new ModelAndView("sudQuery");
		if (type.equalsIgnoreCase("save")) {
			dao.saveQuery(name, query);
			String resultGson = "";
			mv.addObject("resultGson", resultGson);
			return mv;

		} else if (type.equalsIgnoreCase("update")) {
			dao.updateQuery(name, new_name);
			String resultGson = "";
			mv.addObject("resultGson", resultGson);
			return mv;

		} else if (type.equalsIgnoreCase("delete")) {
			dao.deleteQuery(name);
			String resultGson = "";
			mv.addObject("resultGson", resultGson);
			return mv;
		} else {

			List result = dao.customQuery(query);

			Gson gson = new Gson();
			// convert your list to json

			String resultGson = gson.toJson(result);
			System.out.println(resultGson);

			mv.addObject("resultGson", resultGson);
			return mv;

		}

	}

	@RequestMapping(value = "/innerJoin", method = RequestMethod.POST)
	public ModelAndView innerJoin(
			@RequestParam(value = "innerArr[]") String[] innerArr,
			@RequestParam(value = "currTable") String currTable) {

		String parent, firstChild;
		try {
			parent = dao.getParent(currTable, innerArr).toString();
		} catch (Exception e) {
			parent = null;
		}

		try {
			firstChild = dao.getChild(currTable, innerArr).toString();
		} catch (Exception e) {
			firstChild = null;
		}

		System.out.println(Arrays.toString(innerArr) + "   " + currTable);
		// System.out.println(isPresent(innerArr,dao.getParent(currTable).toString())
		// + " yolooooooooo");

		if (parent != null) {
			// parent = dao.getParent(currTable,innerArr).toString();

			Object[] o1 = dao.getColumns(parent, currTable);
			System.out.println(o1 + "newwwwwwwwwwwwwwwwwww1");

			String o[] = new String[5];

			for (int i = 0; i < o1.length - 1; i++) {
				o[i] = (String) o1[i];
			}

			o[4] = currTable;

			Gson gson = new Gson();
			// convert your list to json

			String joins = gson.toJson(o);
			System.out.println(joins + "heuehuehuehuehu");

			ModelAndView mv = new ModelAndView("innerJoin");
			mv.addObject("joins", joins);
			return mv;

		} else if (firstChild != null) {
			// firstChild = dao.getChild(currTable,innerArr).toString();
			Object[] o1 = dao.getColumns(currTable, firstChild);
			System.out.println(Arrays.toString(o1) + "newwwwwwwwwwwwwwwwwww2");
			String o[] = new String[5];

			for (int i = 0; i < o1.length - 1; i++) {
				o[i] = (String) o1[i];
			}

			o[4] = currTable;

			Gson gson = new Gson();
			// convert your list to json

			String joins = gson.toJson(o);
			System.out.println(joins + "heuehuehuehuehu");

			ModelAndView mv = new ModelAndView("innerJoin");
			mv.addObject("joins", joins);
			return mv;
		} else {
			List<Object> existing = new ArrayList<Object>();
			List<Object> newTable = new ArrayList<Object>();
			List<String> common = new ArrayList<String>();

			for (int i = 0; i < innerArr.length; i++) {
				if (!innerArr[i].equalsIgnoreCase(currTable)) {
					Object[] t1 = dao.getParentsAndChildren(innerArr[i]);
					for (int j = 0; j < t1.length; j++)
						existing.add(t1[j]);
				}
			}

			Object[] t2 = dao.getParentsAndChildren(currTable);
			for (int j = 0; j < t2.length; j++)
				newTable.add(t2[j]);

			for (Object o : existing) {
				for (Object p : newTable) {
					if (p.equals(o))
						common.add((String) o);

				}
			}

			common.add(0, "common1");
			common.add(1, currTable);

			String[] commArr = new String[common.size()];
			commArr = common.toArray(commArr);

			System.out.println(Arrays.toString(commArr)
					+ "  controller commArr");

			Gson gson = new Gson();
			// convert your list to json

			String joins = gson.toJson(commArr);

			ModelAndView mv = new ModelAndView("innerJoin");
			mv.addObject("joins", joins);
			return mv;
		}

	}
	
	
	
	@RequestMapping(value = "/updateCustom",method = RequestMethod.POST)
	public void updateCustom(@RequestParam("query") String query) {

		dao.updateCustomQuery(query);

		
	}

	public List<String> getClasses(String packageName) {
		List<String> allClasses = new ArrayList<String>();
		List<ClassLoader> classLoadersList = new LinkedList<ClassLoader>();
		classLoadersList.add(ClasspathHelper.contextClassLoader());
		classLoadersList.add(ClasspathHelper.staticClassLoader());

		Reflections reflections = new Reflections(new ConfigurationBuilder()
				.setScanners(new SubTypesScanner(false /*
														 * don't exclude
														 * Object.class
														 */),
						new ResourcesScanner())
				.setUrls(
						ClasspathHelper.forClassLoader(classLoadersList
								.toArray(new ClassLoader[0])))
				.filterInputsBy(
						new FilterBuilder().include(FilterBuilder
								.prefix(packageName))));

		Set<Class<?>> classes = reflections.getSubTypesOf(Object.class);
		for (Class<?> c : classes) {
			allClasses.add(c.toString().substring(21));
		}
		return allClasses;

	}

	public static boolean isPresent(String[] arr, String val) {
		for (String s : arr) {
			if (s.replaceAll("\\s+", "").equalsIgnoreCase(
					val.replaceAll("\\s+", ""))) {
				// this will also take care of spaces like tabs etc.
				return true;
			}

		}
		return false;
	}

}
