package com.yolo.beans;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;
 
@Entity
@Table(name = "STUDENT99", schema = "LMS_SOL1")
public class Student99 {
 
    @Id
    @GeneratedValue
    @Column(name = "STUDENT_ID")
    private int STUDENT_ID;
 
    @Column(name = "FIRST_NAME")
    private String FIRST_NAME;
 
    @Column(name = "LAST_NAME")
    private String LAST_NAME;
 
    @Column(name = "SECTION")
    private String SECTION;
 
    @OneToOne
    @JoinColumn(name="HOME_ADDRESS_ID")
    private Address99 HOME_ADDRESS_ID;
    
    @OneToOne
    @JoinColumn(name="MarkSheet_Id")
    private MarkSheet99 MarkSheet_Id;
 
 
    public MarkSheet99 getMarkSheet_Id() {
		return MarkSheet_Id;
	}


	public void setMarkSheet_Id(MarkSheet99 markSheet_Id) {
		MarkSheet_Id = markSheet_Id;
	}


	public Student99() {
 
    }
 

	public long getSTUDENT_ID() {
		return STUDENT_ID;
	}

	public void setSTUDENT_ID(int sTUDENT_ID) {
		STUDENT_ID = sTUDENT_ID;
	}

	public String getFIRST_NAME() {
		return FIRST_NAME;
	}

	public void setFIRST_NAME(String fIRST_NAME) {
		FIRST_NAME = fIRST_NAME;
	}

	public String getLAST_NAME() {
		return LAST_NAME;
	}

	public void setLAST_NAME(String lAST_NAME) {
		LAST_NAME = lAST_NAME;
	}

	public String getSECTION() {
		return SECTION;
	}

	public void setSECTION(String sECTION) {
		SECTION = sECTION;
	}

	public Address99 getHOME_ADDRESS_ID() {
		return HOME_ADDRESS_ID;
	}

	public void setHOME_ADDRESS_ID(Address99 hOME_ADDRESS_ID) {
		HOME_ADDRESS_ID = hOME_ADDRESS_ID;
	}
 
   
 
   
 
}