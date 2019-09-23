package com.wuxi.shop.pojo;

public class Orderitem {
    private String itemid;

    private Integer count;

    private Double subtotal;

    private String pid;

    private String oid;

    public Orderitem(String itemid, Integer count, Double subtotal, String pid, String oid) {
        this.itemid = itemid;
        this.count = count;
        this.subtotal = subtotal;
        this.pid = pid;
        this.oid = oid;
    }

    public Orderitem() {
        super();
    }

    public String getItemid() {
        return itemid;
    }

    public void setItemid(String itemid) {
        this.itemid = itemid == null ? null : itemid.trim();
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

    public Double getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(Double subtotal) {
        this.subtotal = subtotal;
    }

    public String getPid() {
        return pid;
    }

    public void setPid(String pid) {
        this.pid = pid == null ? null : pid.trim();
    }

    public String getOid() {
        return oid;
    }

    public void setOid(String oid) {
        this.oid = oid == null ? null : oid.trim();
    }
}