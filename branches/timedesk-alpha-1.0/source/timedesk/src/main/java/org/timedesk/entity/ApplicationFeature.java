package org.timedesk.entity;

import javax.persistence.Column;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.tostring.RooToString;
import org.springframework.roo.addon.entity.RooEntity;

@RooJavaBean
@RooToString
@RooEntity
@Table(name = "application_feature")
public class ApplicationFeature 
{
	@NotNull
	@Column(name = "feature_id")
    private String featureId;

	@NotNull
	@Column(name = "name")
    private String name;

	@Column(name = "description")
    private String description;
}
