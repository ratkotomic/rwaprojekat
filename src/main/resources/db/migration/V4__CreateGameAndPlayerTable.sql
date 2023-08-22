CREATE TABLE `game`
(
    `pin`        VARCHAR(6) NOT NULL,
    `quiz_id`    VARCHAR(45) NULL,
    `creator_id` VARCHAR(45) NULL,
    `status`     VARCHAR(100) NULL,
    PRIMARY KEY (`pin`),
    INDEX        `quiz_game_fk_idx` (`quiz_id` ASC) VISIBLE,
    INDEX        `creator_game_fk_idx` (`creator_id` ASC) VISIBLE,
    CONSTRAINT `quiz_game_fk`
        FOREIGN KEY (`quiz_id`)
            REFERENCES `quiz` (`id`)
            ON DELETE CASCADE
            ON UPDATE NO ACTION,
    CONSTRAINT `creator_game_fk`
        FOREIGN KEY (`creator_id`)
            REFERENCES `user` (`id`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
);

CREATE TABLE `player`
(
    `id`         VARCHAR(45) NOT NULL,
    `game_id`    VARCHAR(45) NULL,
    `first_name` VARCHAR(45) NULL,
    `last_name`  VARCHAR(45) NULL,
    `points`     INT NULL,
    PRIMARY KEY (`id`),
    INDEX        `player_game_fk_idx` (`game_id` ASC) VISIBLE,
    CONSTRAINT `player_game_fk`
        FOREIGN KEY (`game_id`)
            REFERENCES `game` (`pin`)
            ON DELETE CASCADE
            ON UPDATE NO ACTION
);
