package com.yolo.beans;


//import javax.persistence.Column;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
//import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
//import javax.validation.constraints.Min;

//import javax.validation.constraints.Pattern;
//import javax.validation.constraints.Size;

//import org.hibernate.validator.constraints.Email;
//import org.hibernate.validator.constraints.NotEmpty;
//import org.springframework.format.annotation.NumberFormat;
//import org.springframework.format.annotation.NumberFormat.Style;

//import javax.validation.constraints.NotNull;
 
@Entity
@Table(name = "emp99", schema = "LMS_SOL1")
public class Emp99 
{ 
@Id 
@Column(name = "id")
@GeneratedValue
private int id; 

@Column(name = "col",nullable = true)
private Integer col; 



@Column(name = "name")
private String name;

@Column(name = "salary")
private float salary;

@Column(name = "department")
private String department;  
  
public int getId() {  
    return id;  
}  
public void setId(int id) {  
    this.id = id;  
}  
public String getName() {  
    return name;  
}  
public void setName(String name) {  
    this.name = name;  
}  
public float getSalary() {  
    return salary;  
}  
public void setSalary(float salary) {  
    this.salary = salary;  
}  
public String getdepartment() {  
    return department;  
}  
public void setdepartment(String department) {  
    this.department = department;  
}  

public int getCol() {
	return col;
}
public void setCol(int col) {
	this.col = col;
}
  
}  
