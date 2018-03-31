-- MySQL Script generated by MySQL Workbench
-- Mon Dec 18 17:09:36 2017
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema estu
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema estu
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `estu` DEFAULT CHARACTER SET utf8 ;
USE `estu` ;

-- -----------------------------------------------------
-- Table `estu`.`post_category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `estu`.`post_category` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(256) NOT NULL,
  `create_time` TIMESTAMP NOT NULL,
  `last_modified` TIMESTAMP NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `estu`.`post`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `estu`.`post` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `body` LONGTEXT NOT NULL,
  `title` NVARCHAR(256) NOT NULL,
  `create_time` TIMESTAMP NOT NULL,
  `last_modified` TIMESTAMP NULL,
  `rating` INT NULL,
  `image_url` VARCHAR(1000) NULL,
  `category_id` INT NOT NULL,
  PRIMARY KEY (`id`, `category_id`),
  INDEX `fk_post_post_category1_idx` (`category_id` ASC),
  CONSTRAINT `fk_post_post_category1`
    FOREIGN KEY (`category_id`)
    REFERENCES `estu`.`post_category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `estu`.`attachment_category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `estu`.`attachment_category` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(256) NOT NULL,
  `create_time` TIMESTAMP NULL,
  `last_modified` TIMESTAMP NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `estu`.`post_attachment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `estu`.`post_attachment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `post_attachment_category_id` INT NOT NULL,
  `attachment_category_id` INT NOT NULL,
  `name` VARCHAR(256) NOT NULL,
  `create_time` TIMESTAMP NOT NULL,
  `last_modified` TIMESTAMP NULL,
  PRIMARY KEY (`id`, `post_attachment_category_id`, `attachment_category_id`),
  INDEX `fk_post_attachment_attachment_category1_idx` (`attachment_category_id` ASC),
  CONSTRAINT `fk_post_attachment_attachment_category1`
    FOREIGN KEY (`attachment_category_id`)
    REFERENCES `estu`.`attachment_category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `estu`.`post_has_post_attachment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `estu`.`post_has_post_attachment` (
  `post_id` INT NOT NULL,
  `post_attachment_id` INT NOT NULL,
  PRIMARY KEY (`post_id`, `post_attachment_id`),
  INDEX `fk_post_has_post_attachment_post_attachment1_idx` (`post_attachment_id` ASC),
  INDEX `fk_post_has_post_attachment_post1_idx` (`post_id` ASC),
  CONSTRAINT `fk_post_has_post_attachment_post1`
    FOREIGN KEY (`post_id`)
    REFERENCES `estu`.`post` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_post_has_post_attachment_post_attachment1`
    FOREIGN KEY (`post_attachment_id`)
    REFERENCES `estu`.`post_attachment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `estu`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `estu`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(16) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `first_name` VARCHAR(255) NULL,
  `last_name` VARCHAR(255) NULL,
  `password` BINARY(60) NOT NULL,
  `last_login` TIMESTAMP NULL,
  `enabled` TINYINT NOT NULL,
  `create_time` TIMESTAMP NULL,
  `last_modified` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC));


-- -----------------------------------------------------
-- Table `estu`.`post_has_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `estu`.`post_has_user` (
  `post_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`post_id`, `user_id`),
  INDEX `fk_post_has_user_user1_idx` (`user_id` ASC),
  INDEX `fk_post_has_user_post1_idx` (`post_id` ASC),
  CONSTRAINT `fk_post_has_user_post1`
    FOREIGN KEY (`post_id`)
    REFERENCES `estu`.`post` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_post_has_user_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `estu`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `estu`.`post_comment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `estu`.`post_comment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `post_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `body` VARCHAR(1200) NOT NULL,
  `likes` INT NULL DEFAULT 0,
  `dislikes` INT NULL DEFAULT 0,
  `parent_id` INT NULL DEFAULT 0,
  `create_time` TIMESTAMP NOT NULL,
  `last_modified` TIMESTAMP NULL,
  PRIMARY KEY (`id`, `post_id`, `user_id`),
  INDEX `fk_post_comment_post1_idx` (`post_id` ASC),
  INDEX `fk_post_comment_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_post_comment_post1`
    FOREIGN KEY (`post_id`)
    REFERENCES `estu`.`post` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_post_comment_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `estu`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `estu`.`post_book`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `estu`.`post_book` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `post_id` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`, `post_id`),
  INDEX `fk_book_post1_idx` (`post_id` ASC),
  CONSTRAINT `fk_book_post1`
    FOREIGN KEY (`post_id`)
    REFERENCES `estu`.`post` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `estu`.`post_tutorial`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `estu`.`post_tutorial` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `post_id` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`, `post_id`),
  INDEX `fk_tutorial_post1_idx` (`post_id` ASC),
  CONSTRAINT `fk_tutorial_post1`
    FOREIGN KEY (`post_id`)
    REFERENCES `estu`.`post` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `estu`.`post_movie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `estu`.`post_movie` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `post_id` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`, `post_id`),
  INDEX `fk_movie_post1_idx` (`post_id` ASC),
  CONSTRAINT `fk_movie_post1`
    FOREIGN KEY (`post_id`)
    REFERENCES `estu`.`post` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `estu`.`post_series`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `estu`.`post_series` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `post_id` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`, `post_id`),
  INDEX `fk_series_post1_idx` (`post_id` ASC),
  CONSTRAINT `fk_series_post1`
    FOREIGN KEY (`post_id`)
    REFERENCES `estu`.`post` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `estu`.`role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `estu`.`role` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `display_name` VARCHAR(255) NULL,
  `description` VARCHAR(255) NULL,
  `create_time` TIMESTAMP NULL,
  `last_modified` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `estu`.`permission`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `estu`.`permission` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `description` VARCHAR(255) NULL,
  `create_time` TIMESTAMP NOT NULL,
  `last_modified` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `estu`.`user_has_role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `estu`.`user_has_role` (
  `user_id` INT NOT NULL,
  `role_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `role_id`),
  INDEX `fk_user_has_role_role1_idx` (`role_id` ASC),
  INDEX `fk_user_has_role_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_role_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `estu`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_role_role1`
    FOREIGN KEY (`role_id`)
    REFERENCES `estu`.`role` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `estu`.`role_has_permission`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `estu`.`role_has_permission` (
  `role_id` INT NOT NULL,
  `permission_id` INT NOT NULL,
  PRIMARY KEY (`role_id`, `permission_id`),
  INDEX `fk_role_has_permission_permission1_idx` (`permission_id` ASC),
  INDEX `fk_role_has_permission_role1_idx` (`role_id` ASC),
  CONSTRAINT `fk_role_has_permission_role1`
    FOREIGN KEY (`role_id`)
    REFERENCES `estu`.`role` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_role_has_permission_permission1`
    FOREIGN KEY (`permission_id`)
    REFERENCES `estu`.`permission` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;