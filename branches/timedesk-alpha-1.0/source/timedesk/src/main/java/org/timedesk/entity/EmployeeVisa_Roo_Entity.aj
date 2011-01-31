// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package org.timedesk.entity;

import java.lang.Integer;
import java.lang.Long;
import java.util.List;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityManager;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.PersistenceContext;
import javax.persistence.Version;
import org.springframework.transaction.annotation.Transactional;
import org.timedesk.entity.EmployeeVisa;

privileged aspect EmployeeVisa_Roo_Entity {
    
    declare @type: EmployeeVisa: @Entity;
    
    @PersistenceContext
    transient EntityManager EmployeeVisa.entityManager;
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private Long EmployeeVisa.id;
    
    @Version
    @Column(name = "version")
    private Integer EmployeeVisa.version;
    
    public Long EmployeeVisa.getId() {
        return this.id;
    }
    
    public void EmployeeVisa.setId(Long id) {
        this.id = id;
    }
    
    public Integer EmployeeVisa.getVersion() {
        return this.version;
    }
    
    public void EmployeeVisa.setVersion(Integer version) {
        this.version = version;
    }
    
    @Transactional
    public void EmployeeVisa.persist() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.persist(this);
    }
    
    @Transactional
    public void EmployeeVisa.remove() {
        if (this.entityManager == null) this.entityManager = entityManager();
        if (this.entityManager.contains(this)) {
            this.entityManager.remove(this);
        } else {
            EmployeeVisa attached = this.entityManager.find(this.getClass(), this.id);
            this.entityManager.remove(attached);
        }
    }
    
    @Transactional
    public void EmployeeVisa.flush() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.flush();
    }
    
    @Transactional
    public EmployeeVisa EmployeeVisa.merge() {
        if (this.entityManager == null) this.entityManager = entityManager();
        EmployeeVisa merged = this.entityManager.merge(this);
        this.entityManager.flush();
        return merged;
    }
    
    public static final EntityManager EmployeeVisa.entityManager() {
        EntityManager em = new EmployeeVisa().entityManager;
        if (em == null) throw new IllegalStateException("Entity manager has not been injected (is the Spring Aspects JAR configured as an AJC/AJDT aspects library?)");
        return em;
    }
    
    public static long EmployeeVisa.countEmployeeVisas() {
        return entityManager().createQuery("select count(o) from EmployeeVisa o", Long.class).getSingleResult();
    }
    
    public static List<EmployeeVisa> EmployeeVisa.findAllEmployeeVisas() {
        return entityManager().createQuery("select o from EmployeeVisa o", EmployeeVisa.class).getResultList();
    }
    
    public static EmployeeVisa EmployeeVisa.findEmployeeVisa(Long id) {
        if (id == null) return null;
        return entityManager().find(EmployeeVisa.class, id);
    }
    
    public static List<EmployeeVisa> EmployeeVisa.findEmployeeVisaEntries(int firstResult, int maxResults) {
        return entityManager().createQuery("select o from EmployeeVisa o", EmployeeVisa.class).setFirstResult(firstResult).setMaxResults(maxResults).getResultList();
    }
    
}