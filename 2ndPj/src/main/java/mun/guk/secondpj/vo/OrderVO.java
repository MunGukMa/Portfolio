package mun.guk.secondpj.vo;

import lombok.Data;

@Data
public class OrderVO 
{
	int ordernum;
	int prdtnum;
	String prdtname;
	int prdtprice;
	int orderqt;
	String sellerid;
	String buyerid;
	String buyeraddress;
	String buyertel;
	String request;
	String shipstate;
	String orderdate;
}
