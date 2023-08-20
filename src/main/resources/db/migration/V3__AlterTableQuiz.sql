ALTER TABLE `quiz`
    CHANGE COLUMN `image_url` `image_url` TEXT NULL DEFAULT NULL;

ALTER TABLE `question`
    ADD COLUMN `question_number` INT NULL AFTER `quiz_id`;