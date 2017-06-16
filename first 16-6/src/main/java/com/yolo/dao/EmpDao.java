package com.yolo.dao;

import java.util.Arrays;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;

import org.hibernate.Hibernate;
//import org.hibernate.Criteria;

import javax.persistence.Query;

//import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.type.StringType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.google.gson.Gson;
import com.yolo.beans.*;

import org.springframework.transaction.annotation.Transactional;

@Repository
public class EmpDao {
	EntityManagerFactory emf = Persistence
			.createEntityManagerFactory("oracleTest");

	@Autowired
	private SessionFactory sessionFactory;

	@Transactional
	public void addEmp(Emp99 emp) {
		sessionFactory.getCurrentSession().save(emp);
	}

	@Transactional
	public void removeEmp(Integer id) {
		Emp99 emp = (Emp99) sessionFactory.getCurrentSession().load(
				Emp99.class, id);
		if (null != emp) {
			sessionFactory.getCurrentSession().delete(emp);
		}
	}

	@SuppressWarnings("unchecked")
	@Transactional
	public List<Emp99> listEmp() {

		EntityManager em = emf.createEntityManager();
		Query nativeQuery = em.createNativeQuery("SELECT * FROM EMP99");
		List<Emp99> l = nativeQuery.getResultList();
		return l;

		/*
		 * return sessionFactory.getCurrentSession()
		 * .createQuery("from Emp").list();
		 */
	}

	public void saveQuery(String query_name, String query_exec) {
		EntityManager em = emf.createEntityManager();
		EntityTransaction et = em.getTransaction();
		et.begin();
		query_exec = query_exec.replaceAll("'", "''");
		String sq = "INSERT INTO save_query (query_name, query_exec) VALUES ('"
				+ query_name + "','" + query_exec + "')";
		//sq = sq.replaceAll("'","''");
		
		System.out.println(sq + " sqqqqqqqqqqqqqqqqq");
		Query query = em
				.createNativeQuery(sq);
		query.executeUpdate();
		et.commit();
	}

	public void updateQuery(String query_name, String new_name) {
		EntityManager em = emf.createEntityManager();
		EntityTransaction et = em.getTransaction();
		et.begin();
		Query query = em
				.createNativeQuery("UPDATE save_query set query_name ='"
						+ new_name + "' where query_name='" + query_name + "' ");
		System.out.println(query);
		query.executeUpdate();
		et.commit();

	}

	public void deleteQuery(String query_name) {
		EntityManager em = emf.createEntityManager();
		EntityTransaction et = em.getTransaction();
		et.begin();
		Query query = em
				.createNativeQuery("DELETE FROM save_query WHERE query_name = '"
						+ query_name + "'");
		query.executeUpdate();
		et.commit();

	}

	public void updateCustomQuery(String query_exec) {
		EntityManager em = emf.createEntityManager();
		EntityTransaction et = em.getTransaction();
		et.begin();
		Query query = em.createNativeQuery(query_exec);
		System.out.println(query);
		query.executeUpdate();
		et.commit();

	}

	@SuppressWarnings("unchecked")
	@Transactional
	public List customQuery(String query) {

		EntityManager em = emf.createEntityManager();
		Query nativeQuery = em.createNativeQuery(query);
		List<Object[]> l = nativeQuery.getResultList();

		return l;

		/*
		 * return sessionFactory.getCurrentSession()
		 * .createQuery("from Emp").list();
		 */
	}

	@SuppressWarnings("unchecked")
	@Transactional
	public Object[] getParentsAndChildren(String currTable) {

		EntityManager em = emf.createEntityManager();
		String query = "SELECT c.table_name CHILD_TABLE, p.table_name PARENT_TABLE FROM user_constraints p, user_constraints c WHERE (p.constraint_type = 'P' OR p.constraint_type = 'U') AND c.constraint_type = 'R' AND p.constraint_name = c.r_constraint_name AND upper(c.table_name) = UPPER('"
				+ currTable + "')";
		// System.out.println(query);
		Query nativeQuery = em.createNativeQuery(query);
		List<Object[]> l1 = nativeQuery.getResultList();

		String query1 = "SELECT p.table_name PARENT_TABLE, c.table_name CHILD_TABLE FROM user_constraints p, user_constraints c WHERE (p.constraint_type = 'P' OR p.constraint_type = 'U') AND c.constraint_type = 'R' AND p.constraint_name = c.r_constraint_name AND p.table_name = UPPER('"
				+ currTable + "')";
		// System.out.println(query1);
		Query nativeQuery1 = em.createNativeQuery(query1);
		List<Object[]> l2 = nativeQuery1.getResultList();
		// System.out.println(l);

		Object o[] = new Object[l1.size() + l2.size()];

		int i = 0;
		if (!l1.isEmpty()) {

			for (Object[] yo : l1) {
				o[i++] = yo[1];

			}

		}

		if (!l2.isEmpty()) {

			for (Object[] yo : l2) {
				o[i++] = yo[1];

			}

		}

		System.out.println(currTable + "   " + Arrays.toString(o));
		return o;

	}

	@SuppressWarnings("unchecked")
	@Transactional
	public Object getParent(String currTable, String[] innerArr) {

		EntityManager em = emf.createEntityManager();
		String query = "SELECT c.table_name CHILD_TABLE, p.table_name PARENT_TABLE FROM user_constraints p, user_constraints c WHERE (p.constraint_type = 'P' OR p.constraint_type = 'U') AND c.constraint_type = 'R' AND p.constraint_name = c.r_constraint_name AND upper(c.table_name) = UPPER('"
				+ currTable + "')";
		System.out.println(query);
		Query nativeQuery = em.createNativeQuery(query);
		List<Object[]> l1 = nativeQuery.getResultList();
		// System.out.println(l);

		Object o[] = new Object[l1.size()];

		if (!l1.isEmpty()) {
			int i = 0;
			for (Object[] yo : l1) {
				o[i++] = yo[1];

			}

			String[] stringo = Arrays.asList(o).toArray(new String[o.length]);

			for (int a = 0; a < stringo.length; a++) {
				for (int b = 0; b < innerArr.length; b++) {

					if (stringo[a].equalsIgnoreCase(innerArr[b]))
						return stringo[a];

				}
			}

			return null;

		}

		else
			return null;

	}

	@SuppressWarnings("unchecked")
	@Transactional
	public Object getChild(String currTable, String[] innerArr) {

		System.out.println(currTable + "curr");
		EntityManager em = emf.createEntityManager();
		String query = "SELECT p.table_name PARENT_TABLE, c.table_name CHILD_TABLE FROM user_constraints p, user_constraints c WHERE (p.constraint_type = 'P' OR p.constraint_type = 'U') AND c.constraint_type = 'R' AND p.constraint_name = c.r_constraint_name AND p.table_name = UPPER('"
				+ currTable + "')";
		System.out.println(query);
		Query nativeQuery = em.createNativeQuery(query);
		List<Object[]> l1 = nativeQuery.getResultList();

		Object o[] = new Object[l1.size()];

		if (!l1.isEmpty()) {
			int i = 0;
			for (Object[] yo : l1) {
				o[i++] = yo[1];

			}

			String[] stringo = Arrays.asList(o).toArray(new String[o.length]);

			for (int a = 0; a < stringo.length; a++) {
				for (int b = 0; b < innerArr.length; b++) {

					if (stringo[a].equalsIgnoreCase(innerArr[b]))
						return stringo[a];

				}
			}

			return null;

		}

		else
			return null;

		/*
		 * System.out.println(l1); if(!l1.isEmpty()) o = l1.get(0); else return
		 * null;
		 * 
		 * if(o.length == 0) return null; else return o[1];
		 */

	}

	@SuppressWarnings("unchecked")
	@Transactional
	public Object[] getColumns(String parent, String child) {

		Object[] o = {};

		EntityManager em = emf.createEntityManager();
		String query = "SELECT a.table_name, c.column_name, b.table_name AS CHILD_TABLE, d.column_name as yolo, b.R_CONSTRAINT_NAME FROM user_constraints a, user_constraints b, user_ind_columns c, user_cons_columns d WHERE a.constraint_type = 'P' AND a.CONSTRAINT_NAME = b.R_CONSTRAINT_NAME AND b.CONSTRAINT_TYPE = 'R' AND a.table_name = c.table_name AND a.constraint_name = c.index_name AND b.CONSTRAINT_NAME = d.constraint_name AND upper(a.table_name) like upper('"
				+ parent
				+ "') AND upper(b.table_name) like upper('"
				+ child
				+ "')";
		System.out.println(query);
		Query nativeQuery = em.createNativeQuery(query);
		List<Object[]> l1 = nativeQuery.getResultList();
		System.out.println(l1.get(0)[1] + "              " + l1.get(0)[3]);
		if (!l1.isEmpty())
			o = l1.get(0);
		else
			return null;

		if (o.length == 0)
			return null;
		else
			return o;

	}

	@Transactional
	public void updateEmp(Emp99 emp) {
		sessionFactory.getCurrentSession().update(emp);
	}

	@Transactional
	@SuppressWarnings("unchecked")
	public Emp99 getEmpById(Integer id) {
		Session session = sessionFactory.getCurrentSession();
		List<Emp99> list = session
				.createQuery("from Emp emp where emp.id = :id")
				.setParameter("id", id).list();
		return list.size() > 0 ? (Emp99) list.get(0) : null;
	}

	/*
	 * @Transactional
	 * 
	 * @SuppressWarnings("unchecked") public List<Emp> getDepEmployees(String
	 * department) {
	 * 
	 * Query query = sessionFactory.getCurrentSession().createQuery(
	 * "from Emp e where e.department = ?"); query.setParameter(0, department);
	 * //System.out.println(query.list().toString()); return query.list();
	 * 
	 * }
	 */
}
