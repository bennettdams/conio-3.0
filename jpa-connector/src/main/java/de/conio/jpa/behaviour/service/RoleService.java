package de.conio.jpa.behaviour.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import de.conio.jpa.behaviour.dao.RoleRepository;
import de.conio.jpa.structure.security.RoleEntity;

@Service
public class RoleService extends CrudService<RoleEntity>{

	@Autowired
	private RoleRepository roleRepository;

	protected RoleRepository getRepository() {
		return roleRepository;
	}
	
	public List<String> findAllWithNameOnly(){
		return getRepository().findAllWithNameOnly();
	}
	
	public RoleEntity findOneByName(String name) {
		return getRepository().findOneByName(name);
	}
}