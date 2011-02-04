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
import org.timedesk.entity.CompanySite;

privileged aspect CompanySite_Roo_Entity {
    
    declare @type: CompanySite: @Entity;
    
    @PersistenceContext
    transient EntityManager CompanySite.entityManager;
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private Long CompanySite.id;
    
    @Version
    @Column(name = "version")
    private Integer CompanySite.version;
    
    public Long CompanySite.getId() {
        return this.id;
    }
    
    public void CompanySite.setId(Long id) {
        this.id = id;
    }
    
    public Integer CompanySite.getVersion() {
        return this.version;
    }
    
    public void CompanySite.setVersion(Integer version) {
        this.version = version;
    }
    
    @Transactional
    public void CompanySite.persist() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.persist(this);
    }
    
    @Transactional
    public void CompanySite.remove() {
        if (this.entityManager == null) this.entityManager = entityManager();
        if (this.entityManager.contains(this)) {
            this.entityManager.remove(this);
        } else {
            CompanySite attached = this.entityManager.find(this.getClass(), this.id);
            this.entityManager.remove(attached);
        }
    }
    
    @Transactional
    public void CompanySite.flush() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.flush();
    }
    
    @Transactional
    public CompanySite CompanySite.merge() {
        if (this.entityManager == null) this.entityManager = entityManager();
        CompanySite merged = this.entityManager.merge(this);
        this.entityManager.flush();
        return merged;
    }
    
    public static final EntityManager CompanySite.entityManager() {
        EntityManager em = new CompanySite().entityManager;
        if (em == null) throw new IllegalStateException("Entity manager has not been injected (is the Spring Aspects JAR configured as an AJC/AJDT aspects library?)");
        return em;
    }
    
    public static long CompanySite.countCompanySites() {
        return entityManager().createQuery("select count(o) from CompanySite o", Long.class).getSingleResult();
    }
    
    public static List<CompanySite> CompanySite.findAllCompanySites() {
        return entityManager().createQuery("select o from CompanySite o", CompanySite.class).getResultList();
    }
    
    public static List<CompanySite> CompanySite.findCompanySiteEntries(int firstResult, int maxResults) {
        return entityManager().createQuery("select o from CompanySite o", CompanySite.class).setFirstResult(firstResult).setMaxResults(maxResults).getResultList();
    }
    
}
