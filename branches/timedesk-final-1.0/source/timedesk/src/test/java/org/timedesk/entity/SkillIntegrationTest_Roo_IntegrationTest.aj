// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package org.timedesk.entity;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;
import org.timedesk.entity.SkillDataOnDemand;

privileged aspect SkillIntegrationTest_Roo_IntegrationTest {
    
    declare @type: SkillIntegrationTest: @RunWith(SpringJUnit4ClassRunner.class);
    
    declare @type: SkillIntegrationTest: @ContextConfiguration(locations = "classpath:/META-INF/spring/applicationContext.xml");
    
    declare @type: SkillIntegrationTest: @Transactional;
    
    @Autowired
    private SkillDataOnDemand SkillIntegrationTest.dod;
    
    @Test
    public void SkillIntegrationTest.testCountSkills() {
        org.junit.Assert.assertNotNull("Data on demand for 'Skill' failed to initialize correctly", dod.getRandomSkill());
        long count = org.timedesk.entity.Skill.countSkills();
        org.junit.Assert.assertTrue("Counter for 'Skill' incorrectly reported there were no entries", count > 0);
    }
    
    @Test
    public void SkillIntegrationTest.testFindSkill() {
        org.timedesk.entity.Skill obj = dod.getRandomSkill();
        org.junit.Assert.assertNotNull("Data on demand for 'Skill' failed to initialize correctly", obj);
        java.lang.Long id = obj.getId();
        org.junit.Assert.assertNotNull("Data on demand for 'Skill' failed to provide an identifier", id);
        obj = org.timedesk.entity.Skill.findSkill(id);
        org.junit.Assert.assertNotNull("Find method for 'Skill' illegally returned null for id '" + id + "'", obj);
        org.junit.Assert.assertEquals("Find method for 'Skill' returned the incorrect identifier", id, obj.getId());
    }
    
    @Test
    public void SkillIntegrationTest.testFindAllSkills() {
        org.junit.Assert.assertNotNull("Data on demand for 'Skill' failed to initialize correctly", dod.getRandomSkill());
        long count = org.timedesk.entity.Skill.countSkills();
        org.junit.Assert.assertTrue("Too expensive to perform a find all test for 'Skill', as there are " + count + " entries; set the findAllMaximum to exceed this value or set findAll=false on the integration test annotation to disable the test", count < 250);
        java.util.List<org.timedesk.entity.Skill> result = org.timedesk.entity.Skill.findAllSkills();
        org.junit.Assert.assertNotNull("Find all method for 'Skill' illegally returned null", result);
        org.junit.Assert.assertTrue("Find all method for 'Skill' failed to return any data", result.size() > 0);
    }
    
    @Test
    public void SkillIntegrationTest.testFindSkillEntries() {
        org.junit.Assert.assertNotNull("Data on demand for 'Skill' failed to initialize correctly", dod.getRandomSkill());
        long count = org.timedesk.entity.Skill.countSkills();
        if (count > 20) count = 20;
        java.util.List<org.timedesk.entity.Skill> result = org.timedesk.entity.Skill.findSkillEntries(0, (int) count);
        org.junit.Assert.assertNotNull("Find entries method for 'Skill' illegally returned null", result);
        org.junit.Assert.assertEquals("Find entries method for 'Skill' returned an incorrect number of entries", count, result.size());
    }
    
    @Test
    public void SkillIntegrationTest.testFlush() {
        org.timedesk.entity.Skill obj = dod.getRandomSkill();
        org.junit.Assert.assertNotNull("Data on demand for 'Skill' failed to initialize correctly", obj);
        java.lang.Long id = obj.getId();
        org.junit.Assert.assertNotNull("Data on demand for 'Skill' failed to provide an identifier", id);
        obj = org.timedesk.entity.Skill.findSkill(id);
        org.junit.Assert.assertNotNull("Find method for 'Skill' illegally returned null for id '" + id + "'", obj);
        boolean modified =  dod.modifySkill(obj);
        java.lang.Integer currentVersion = obj.getVersion();
        obj.flush();
        org.junit.Assert.assertTrue("Version for 'Skill' failed to increment on flush directive", (currentVersion != null && obj.getVersion() > currentVersion) || !modified);
    }
    
    @Test
    public void SkillIntegrationTest.testMerge() {
        org.timedesk.entity.Skill obj = dod.getRandomSkill();
        org.junit.Assert.assertNotNull("Data on demand for 'Skill' failed to initialize correctly", obj);
        java.lang.Long id = obj.getId();
        org.junit.Assert.assertNotNull("Data on demand for 'Skill' failed to provide an identifier", id);
        obj = org.timedesk.entity.Skill.findSkill(id);
        boolean modified =  dod.modifySkill(obj);
        java.lang.Integer currentVersion = obj.getVersion();
        org.timedesk.entity.Skill merged = (org.timedesk.entity.Skill) obj.merge();
        obj.flush();
        org.junit.Assert.assertEquals("Identifier of merged object not the same as identifier of original object", merged.getId(), id);
        org.junit.Assert.assertTrue("Version for 'Skill' failed to increment on merge and flush directive", (currentVersion != null && obj.getVersion() > currentVersion) || !modified);
    }
    
    @Test
    public void SkillIntegrationTest.testPersist() {
        org.junit.Assert.assertNotNull("Data on demand for 'Skill' failed to initialize correctly", dod.getRandomSkill());
        org.timedesk.entity.Skill obj = dod.getNewTransientSkill(Integer.MAX_VALUE);
        org.junit.Assert.assertNotNull("Data on demand for 'Skill' failed to provide a new transient entity", obj);
        org.junit.Assert.assertNull("Expected 'Skill' identifier to be null", obj.getId());
        obj.persist();
        obj.flush();
        org.junit.Assert.assertNotNull("Expected 'Skill' identifier to no longer be null", obj.getId());
    }
    
    @Test
    public void SkillIntegrationTest.testRemove() {
        org.timedesk.entity.Skill obj = dod.getRandomSkill();
        org.junit.Assert.assertNotNull("Data on demand for 'Skill' failed to initialize correctly", obj);
        java.lang.Long id = obj.getId();
        org.junit.Assert.assertNotNull("Data on demand for 'Skill' failed to provide an identifier", id);
        obj = org.timedesk.entity.Skill.findSkill(id);
        obj.remove();
        obj.flush();
        org.junit.Assert.assertNull("Failed to remove 'Skill' with identifier '" + id + "'", org.timedesk.entity.Skill.findSkill(id));
    }
    
}
