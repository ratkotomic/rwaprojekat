CREATE TABLE `quiz`
(
    `id`        VARCHAR(45) NOT NULL,
    `title`     VARCHAR(45) NULL,
    `image_url` VARCHAR(100) NULL,
    `owner_id`  VARCHAR(45) NULL,
    PRIMARY KEY (`id`),
    INDEX       `quiz_user_fk_idx` (`owner_id` ASC) VISIBLE,
    CONSTRAINT `quiz_user_fk`
        FOREIGN KEY (`owner_id`)
            REFERENCES `user` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE
);

CREATE TABLE `question`
(
    `id`             VARCHAR(45) NOT NULL,
    `text`           TEXT NULL,
    `time_to_answer` INT NULL,
    `points`         INT NULL,
    `quiz_id`        VARCHAR(45) NULL,
    PRIMARY KEY (`id`),
    INDEX            `question_quiz_fk_idx` (`quiz_id` ASC) VISIBLE,
    CONSTRAINT `question_quiz_fk`
        FOREIGN KEY (`quiz_id`)
            REFERENCES `quiz` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE
);

CREATE TABLE `answer`
(
    `id`          VARCHAR(45) NOT NULL,
    `text`        TEXT NULL,
    `is_correct`  TINYINT NULL,
    `question_id` VARCHAR(45) NULL,
    PRIMARY KEY (`id`),
    INDEX         `answer_question_fk_idx` (`question_id` ASC) VISIBLE,
    CONSTRAINT `answer_question_fk`
        FOREIGN KEY (`question_id`)
            REFERENCES `question` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE
);