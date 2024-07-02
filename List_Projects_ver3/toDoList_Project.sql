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