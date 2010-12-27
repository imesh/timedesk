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
import org.timedesk.entity.ProjectMember;

privileged aspect ProjectMember_Roo_Entity {
    
    declare @type: ProjectMember: @Entity;
    
    @PersistenceContext
    transient EntityManager ProjectMember.entityManager;
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private Long ProjectMember.id;
    
    @Version
    @Column(name = "version")
    private Integer ProjectMember.version;
    
    public Long ProjectMember.getId() {
        return this.id;
    }
    
    public void ProjectMember.setId(Long id) {
        this.id = id;
    }
    
    public Integer ProjectMember.getVersion() {
        return this.version;
    }
    
    public void ProjectMember.setVersion(Integer version) {
        this.version = version;
    }
    
    @Transactional
    public void ProjectMember.persist() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.persist(this);
    }
    
    @Transactional
    public void ProjectMember.remove() {
        if (this.entityManager == null) this.entityManager = entityManager();
        if (this.entityManager.contains(this)) {
            this.entityManager.remove(this);
        } else {
            ProjectMember attached = this.entityManager.find(this.getClass(), this.id);
            this.entityManager.remove(attached);
        }
    }
    
    @Transactional
    public void ProjectMember.flush() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.flush();
    }
    
    @Transactional
    public ProjectMember ProjectMember.merge() {
        if (this.entityManager == null) this.entityManager = entityManager();
        ProjectMember merged = this.entityManager.merge(this);
        this.entityManager.flush();
        return merged;
    }
    
    public static final EntityManager ProjectMember.entityManager() {
        EntityManager em = new ProjectMember().entityManager;
        if (em == null) throw new IllegalStateException("Entity manager has not been injected (is the Spring Aspects JAR configured as an AJC/AJDT aspects library?)");
        return em;
    }
    
    public static long ProjectMember.countProjectMembers() {
        return entityManager().createQuery("select count(o) from ProjectMember o", Long.class).getSingleResult();
    }
    
    public static List<ProjectMember> ProjectMember.findAllProjectMembers() {
        return entityManager().createQuery("select o from ProjectMember o", ProjectMember.class).getResultList();
    }
    
    public static ProjectMember ProjectMember.findProjectMember(Long id) {
        if (id == null) return null;
        return entityManager().find(ProjectMember.class, id);
    }
    
    public static List<ProjectMember> ProjectMember.findProjectMemberEntries(int firstResult, int maxResults) {
        return entityManager().createQuery("select o from ProjectMember o", ProjectMember.class).setFirstResult(firstResult).setMaxResults(maxResults).getResultList();
    }
    
}
