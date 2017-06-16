package com.yolo.beans;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name = "marksheet99", schema = "LMS_SOL1")
public class MarkSheet99 {


    @Id
    @GeneratedValue
    @Column(name = "mark_id")
    private String mark_id;
 
    @Column(name = "maths")
    private int maths;
 
    @Column(name = "physics")
    private int physics;
 
    public int getPhysics() {
		return physics;
	}

	public void setPhysics(int physics) {
		this.physics = physics;
	}

	@Column(name = "chemistry")
    private int chemistry;
    
    @Column(name = "biology")
    private int biology;

	

	public String getMark_id() {
		return mark_id;
	}

	public void setMark_id(String mark_id) {
		this.mark_id = mark_id;
	}

	public int getMaths() {
		return maths;
	}

	public void setMaths(int maths) {
		this.maths = maths;
	}



	public int getChemistry() {
		return chemistry;
	}

	public void setChemistry(int chemistry) {
		this.chemistry = chemistry;
	}

	public int getBiology() {
		return biology;
	}

	public void setBiology(int biology) {
		this.biology = biology;
	}
    
    
 
 
}
