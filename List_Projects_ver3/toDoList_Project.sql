use bbs;

ALTER TABLE BBS ADD COLUMN uploadFile VARCHAR(255);

ALTER TABLE BBS DROP COLUMN filePath;

ALTER TABLE BBS ADD viewCount INT DEFAULT 0;

use bbs;

SELECT uploadFile FROM BBS WHERE uploadFile IS NOT NULL; 

describe bbs; 







create database BBS;

use bbs;

create table user  -- user table 생성
(
userID varchar(255) not null primary key,
userPassword varchar(50) not null,
userName varchar(50) not null,
userGender varchar(10) not null,
userEmail varchar(100) not null
);
ALTER TABLE user
MODIFY userID VARCHAR(255) NOT NULL;

CREATE TABLE BBS (  -- bbs table 생성
    bbsID INT AUTO_INCREMENT PRIMARY KEY,
    bbsTitle VARCHAR(255) NOT NULL,
    userID VARCHAR(255) NOT NULL,
    bbsDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    bbsContent TEXT NOT NULL,
    bbsAvailable INT DEFAULT 1,
    fileName VARCHAR(255),
    viewCount INT DEFAULT 0
);

-- user테이블의 userID와 bbs테이블의 userID를 join
ALTER TABLE BBS ADD CONSTRAINT fk_userID FOREIGN KEY (userID) REFERENCES User(userID);


-- ToDoList table 생성
-- 사용자의 추가 정보를 자주 조회하거나, 데이터 무결성을 보장해야 하는 경우 조인을 사용하는 것이 좋을듯 함
CREATE TABLE tasks (
    id VARCHAR(36) NOT NULL, -- UUID를 저장할 수 있는 길이
    userID VARCHAR(255) NOT NULL,
    item VARCHAR(255) NOT NULL,
    startDateTime DATETIME NOT NULL,
    dueDateTime DATETIME NOT NULL,
    completed ENUM('yes', 'no') NOT NULL DEFAULT 'no', -- 상태를 'yes' 또는 'no'로 저장
    PRIMARY KEY (id),
    FOREIGN KEY (userID) REFERENCES user(userID) ON DELETE CASCADE
);


INSERT INTO BBS (userID, bbsTitle, bbsContent, bbsAvailable, fileName, viewCount)
VALUES 
('gilsoon', 'gilsoon1', 'gildong1, gildong2, gildong3', 1, NULL, 0),
('gilsoon', 'gilsoon2', 'gildong2', 1, NULL, 0),
('gilsoon', 'gilsoon3', 'gildong3', 1, NULL, 0),
('gilsoon', 'gilsoon4', 'gildong4', 1, NULL, 0),
('gilsoon', 'gilsoon5', 'gildong5', 1, NULL, 0),
('gilsoon', 'gilsoon6', 'gildong6', 1, NULL, 0),
('gilsoon', 'gilsoon7', 'gildong7', 1, NULL, 0),
('gilsoon', 'gilsoon8', 'gildong8', 1, NULL, 0),
('gilsoon', 'gilsoon9', 'gildong9', 1, NULL, 0),
('gilsoon', 'gilsoon10', 'gildong10', 1, NULL, 0),
('gilsoon', 'gilsoon11', 'gildong11', 1, NULL, 0),
('gilsoon', 'gilsoon12', 'gildong12', 1, NULL, 0),
('gilsoon', 'gilsoon13', 'gildong13', 1, NULL, 0),
('gilsoon', 'gilsoon14', 'gildong14', 1, NULL, 0),
('gilsoon', 'gilsoon15', 'gildong15', 1, NULL, 0),
('gilsoon', 'gilsoon16', 'gildong16', 1, NULL, 0),
('gilsoon', 'gilsoon17', 'gildong17', 1, NULL, 0),
('gilsoon', 'gilsoon18', 'gildong18', 1, NULL, 0),
('gilsoon', 'gilsoon19', 'gildong19', 1, NULL, 0),
('gilsoon', 'gilsoon20', 'gildong20, gildong19, gildong18', 1, NULL, 0);


INSERT INTO BBS (userID, bbsTitle, bbsContent, bbsAvailable, fileName, viewCount)
VALUES 
('gilsoon', 'gilsoon21', 'gilsoon1, gilsoon2, gilsoon3', 1, NULL, 0),
('gilsoon', 'gilsoon22', 'gilsoon2', 1, NULL, 0),
('gilsoon', 'gilsoon23', 'gilsoon3', 1, NULL, 0),
('gilsoon', 'gilsoon24', 'gilsoon4', 1, NULL, 0),
('gilsoon', 'gilsoon25', 'gilsoon5', 1, NULL, 0),
('gilsoon', 'gilsoon22', 'gilsoon2', 1, NULL, 0),
('gilsoon', 'gilsoon23', 'gilsoon3', 1, NULL, 0),
('gilsoon', 'gilsoon24', 'gildong4', 1, NULL, 0),
('gilsoon', 'gilsoon25', 'gilsoon5', 1, NULL, 0),
('gilsoon', 'gilsoon26', 'gilsoon6', 1, NULL, 0),
('gilsoon', 'gilsoon27', 'gilsoon7', 1, NULL, 0),
('gilsoon', 'gilsoon28', 'gildong8', 1, NULL, 0),
('gilsoon', 'gilsoon29', 'gildong9', 1, NULL, 0),
('gilsoon', 'gilsoon30', 'gildong10', 1, NULL, 0),
('gilsoon', 'gilsoon31', 'gildong11', 1, NULL, 0),
('gilsoon', 'gilsoon32', 'gildong12', 1, NULL, 0),
('gilsoon', 'gilsoon33', 'gildong13', 1, NULL, 0);

-- 사용자에게 권한 부여
GRANT ALL PRIVILEGES ON bbs.* TO 'root'@'localhost';
FLUSH PRIVILEGES;

SELECT user, host FROM mysql.user;

ALTER USER 'root'@'localhost' IDENTIFIED BY '1234';
FLUSH PRIVILEGES;


SELECT host, user FROM mysql.user WHERE user = 'root';

GRANT ALL PRIVILEGES ON your_database.* TO 'root'@'localhost';
FLUSH PRIVILEGES;

SELECT user, host FROM mysql.user WHERE user = 'root' AND host = 'localhost';

ALTER TABLE bbs ADD COLUMN bbsCategory VARCHAR(255) NOT NULL DEFAULT 'default';

use bbs;

UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '1');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '2');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '3');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '4');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '5');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '6');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '7');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '8');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '9');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '10');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '11');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '12');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '13');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '14');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '15');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '16');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '17');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '18');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '19');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '20');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '21');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '22');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '23');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '24');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '25');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '26');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '27');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '28');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '29');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '30');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '31');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '32');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '33');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '34');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '35');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '36');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '37');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '38');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '39');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '40');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '41');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '42');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '43');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '44');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '45');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '46');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '47');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '48');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '49');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '50');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '51');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '52');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '53');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '54');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '55');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '56');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '57');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '58');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '59');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '60');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '61');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '62');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '63');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '64');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '65');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '66');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '67');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '68');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '69');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '70');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '71');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '72');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '73');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '74');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '75');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '76');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '77');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '78');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '79');
UPDATE `bbs`.`bbs` SET `bbsCategory` = 'free' WHERE (`bbsID` = '80');
