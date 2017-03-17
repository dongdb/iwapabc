package com.nantian.iwap.model;

import java.util.UUID;

public class Asset {
	private String FID;
	private int VERSION;			//number
	private String FMASTERID;		//无初始化
	private String FKIND;			
	private String FKINDID;			//无初始化
	private String FNAME;
	private String FSIMPLENAME;
	private String FZCSL;			//number
	private String FPRICE;			//number
	private String FCURRENCY;
	private String FCURRENCYCODE;	//无初始化
	private String FISFA;
	private String FSPECTYPE;
	private String FUSETYPE;
	private String FUSETYPEID;
	private String FFACTORY;
	private String FFACTORYDATE;	//date
	private String FBUYDATE;		//date
	private String FWARRANTYDATE;	//date
	private String FWARRANTYMONTH;	//number
	private String FUNIT;
	private String FDETAILINFO;
	private String FBUDGET;			//无初始化
	private String FBUDGETID;		//无初始化
	private String FREMARK;
	private String FASSETFILE;		//无初始化
	
	Asset(String FNAME,String FKIND,String FSIMPLENAME,String FZCSL,
			String FPRICE,String FCURRENCY,String FISFA,String FSPECTYPE,String FUSETYPE,
			String FFACTORY,String FFACTORYDATE,String FBUYDATE,String FWARRANTYDATE,
			String FWARRANTYMONTH,String FUNIT,String FDETAILINFO,String FREMARK){
		UUID uuid = UUID.randomUUID();
		this.FID=uuid.toString().replaceAll("-", "");
		this.VERSION=0;
		this.FNAME=FNAME;
		this.FKIND=FKIND;
		this.FSIMPLENAME=FSIMPLENAME;
		this.FZCSL=FZCSL;
		this.FPRICE=FPRICE;
		this.FCURRENCY=FCURRENCY;
		this.FISFA=FISFA;
		this.FSPECTYPE=FSPECTYPE;
		this.FUSETYPE=FUSETYPE;
		this.FUSETYPEID=FUSETYPE;
		this.FFACTORY=FFACTORY;
		this.FFACTORYDATE=FFACTORYDATE;
		this.FBUYDATE=FBUYDATE;
		this.FWARRANTYDATE=FWARRANTYDATE;
		this.FWARRANTYMONTH=FWARRANTYMONTH;
		this.FUNIT=FUNIT;
		this.FDETAILINFO=FDETAILINFO;
		this.FREMARK=FREMARK;
	}
	
	public String getFID() {
		return FID;
	}
	public void setFID(String fID) {
		FID = fID;
	}
	public int getVERSION() {
		return VERSION;
	}
	public void setVERSION(int vERSION) {
		VERSION = vERSION;
	}
	public String getFMASTERID() {
		return FMASTERID;
	}
	public void setFMASTERID(String fMASTERID) {
		FMASTERID = fMASTERID;
	}
	public String getFKIND() {
		return FKIND;
	}
	public void setFKIND(String fKIND) {
		FKIND = fKIND;
	}
	public String getFKINDID() {
		return FKINDID;
	}
	public void setFKINDID(String fKINDID) {
		FKINDID = fKINDID;
	}
	public String getFNAME() {
		return FNAME;
	}

	public void setFNAME(String fNAME) {
		FNAME = fNAME;
	}

	public String getFSIMPLENAME() {
		return FSIMPLENAME;
	}
	public void setFSIMPLENAME(String fSIMPLENAME) {
		FSIMPLENAME = fSIMPLENAME;
	}
	public String getFZCSL() {
		return FZCSL;
	}
	public void setFZCSL(String fZCSL) {
		FZCSL = fZCSL;
	}
	public String getFPRICE() {
		return FPRICE;
	}
	public void setFPRICE(String fPRICE) {
		FPRICE = fPRICE;
	}
	public String getFCURRENCY() {
		return FCURRENCY;
	}
	public void setFCURRENCY(String fCURRENCY) {
		FCURRENCY = fCURRENCY;
	}
	public String getFCURRENCYCODE() {
		return FCURRENCYCODE;
	}
	public void setFCURRENCYCODE(String fCURRENCYCODE) {
		FCURRENCYCODE = fCURRENCYCODE;
	}
	public String getFISFA() {
		return FISFA;
	}
	public void setFISFA(String fISFA) {
		FISFA = fISFA;
	}
	public String getFSPECTYPE() {
		return FSPECTYPE;
	}
	public void setFSPECTYPE(String fSPECTYPE) {
		FSPECTYPE = fSPECTYPE;
	}
	public String getFUSETYPE() {
		return FUSETYPE;
	}
	public void setFUSETYPE(String fUSETYPE) {
		FUSETYPE = fUSETYPE;
	}
	public String getFUSETYPEID() {
		return FUSETYPEID;
	}
	public void setFUSETYPEID(String fUSETYPEID) {
		FUSETYPEID = fUSETYPEID;
	}
	public String getFFACTORY() {
		return FFACTORY;
	}
	public void setFFACTORY(String fFACTORY) {
		FFACTORY = fFACTORY;
	}
	public String getFFACTORYDATE() {
		return FFACTORYDATE;
	}
	public void setFFACTORYDATE(String fFACTORYDATE) {
		FFACTORYDATE = fFACTORYDATE;
	}
	public String getFBUYDATE() {
		return FBUYDATE;
	}
	public void setFBUYDATE(String fBUYDATE) {
		FBUYDATE = fBUYDATE;
	}
	public String getFWARRANTYDATE() {
		return FWARRANTYDATE;
	}
	public void setFWARRANTYDATE(String fWARRANTYDATE) {
		FWARRANTYDATE = fWARRANTYDATE;
	}
	public String getFWARRANTYMONTH() {
		return FWARRANTYMONTH;
	}
	public void setFWARRANTYMONTH(String fWARRANTYMONTH) {
		FWARRANTYMONTH = fWARRANTYMONTH;
	}
	public String getFUNIT() {
		return FUNIT;
	}
	public void setFUNIT(String fUNIT) {
		FUNIT = fUNIT;
	}
	public String getFDETAILINFO() {
		return FDETAILINFO;
	}
	public void setFDETAILINFO(String fDETAILINFO) {
		FDETAILINFO = fDETAILINFO;
	}
	public String getFBUDGET() {
		return FBUDGET;
	}
	public void setFBUDGET(String fBUDGET) {
		FBUDGET = fBUDGET;
	}
	public String getFBUDGETID() {
		return FBUDGETID;
	}
	public void setFBUDGETID(String fBUDGETID) {
		FBUDGETID = fBUDGETID;
	}
	public String getFREMARK() {
		return FREMARK;
	}
	public void setFREMARK(String fREMARK) {
		FREMARK = fREMARK;
	}
	public String getFASSETFILE() {
		return FASSETFILE;
	}
	public void setFASSETFILE(String fASSETFILE) {
		FASSETFILE = fASSETFILE;
	}
	
}
