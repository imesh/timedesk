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
import org.timedesk.entity.ProjectMemberFeedback;

privileged aspect ProjectMemberFeedback_Roo_Entity {
    
    declare @type: ProjectMemberFeedback: @Entity;
    
    @PersistenceContext
    transient EntityManager ProjectMemberFeedback.entityManager;
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private Long ProjectMemberFeedback.id;
    
    @Version
    @Column(name = "version")
    private Integer ProjectMemberFeedback.version;
    
    public Long ProjectMemberFeedback.getId() {
        return this.id;
    }
    
    public void ProjectMemberFeedback.setId(Long id) {
        this.id = id;
    }
    
    public Integer ProjectMemberFeedback.getVersion() {
        return this.version;
    }
    
    public void ProjectMemberFeedback.setVersion(Integer version) {
        this.version = version;
    }
    
    @Transactional
    public void ProjectMemberFeedback.persist() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.persist(this);
    }
    
    @Transactional
    public void ProjectMemberFeedback.remove() {
        if (this.entityManager == null) this.entityManager = entityManager();
        if (this.entityManager.contains(this)) {
            this.entityManager.remove(this);
        } else {
            ProjectMemberFeedback attached = this.entityManager.find(this.getClass(), this.id);
            this.entityManager.remove(attached);
        }
    }
    
    @Transactional
    public void ProjectMemberFeedback.flush() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.flush();
    }
    
    @Transactional
    public ProjectMemberFeedback ProjectMemberFeedback.merge() {
        if (this.entityManager == null) this.entityManager = entityManager();
        ProjectMemberFeedback merged = this.entityManager.merge(this);
        this.entityManager.flush();
        return merged;
    }
    
    public static final EntityManager ProjectMemberFeedback.entityManager() {
        EntityManager em = new ProjectMemberFeedback().entityManager;
        if (em == null) throw new IllegalStateException("Entity manager has not been injected (is the Spring Aspects JAR configured as an AJC/AJDT aspects library?)");
        return em;
    }
    
    public static long ProjectMemberFeedback.countProjectMemberFeedbacks() {
        return entityManager().createQuery("select count(o) from ProjectMemberFeedback o", Long.class).getSingleResult();
    }
    
    public static List<ProjectMemberFeedback> ProjectMemberFeedback.findAllProjectMemberFeedbacks() {
        return entityManager().createQuery("select o from ProjectMemberFeedback o", ProjectMemberFeedback.class).getResultList();
    }
    
    public static ProjectMemberFeedback ProjectMemberFeedback.findProjectMemberFeedback(Long id) {
        if (id == null) return null;
        return entityManager().find(ProjectMemberFeedback.class, id);
    }
    
    public static List<ProjectMemberFeedback> ProjectMemberFeedback.findProjectMemberFeedbackEntries(int firstResult, int maxResults) {
        return entityManager().createQuery("select o from ProjectMemberFeedback o", ProjectMemberFeedback.class).setFirstResult(firstResult).setMaxResults(maxResults).getResultList();
    }
    
}
