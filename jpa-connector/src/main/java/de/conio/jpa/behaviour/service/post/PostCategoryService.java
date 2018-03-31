package de.conio.jpa.behaviour.service.post;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import de.conio.jpa.behaviour.dao.post.PostCategoryRepository;
import de.conio.jpa.behaviour.service.CrudService;
import de.conio.jpa.structure.post.PostCategoryEntity;

@Service
public class PostCategoryService extends CrudService<PostCategoryEntity> {

	@Autowired
	private PostCategoryRepository postCategoryRepository;

	protected PostCategoryRepository getRepository() {
		return postCategoryRepository;
	}

}