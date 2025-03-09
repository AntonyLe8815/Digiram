create database children;

use children;

-- NHÓM 1: QUẢN LÝ NGƯỚI DÙNG

CREATE TABLE Roles (
  RoleID INT PRIMARY KEY AUTO_INCREMENT,  -- ID vai trò
  RoleName VARCHAR(50) NOT NULL           -- Tên vai trò (Admin, User, Doctor)
);

INSERT INTO Roles (RoleName) 
VALUES 
('Admin'), 
('User'), 
('Doctor');

select *from Roles;
 
CREATE TABLE Users (
  UserID INT PRIMARY KEY AUTO_INCREMENT,  
  Username VARCHAR(50) NOT NULL UNIQUE,   
  PasswordHash VARCHAR(255) NOT NULL,     
  Email VARCHAR(100) NOT NULL UNIQUE,     
  FullName VARCHAR(100) NOT NULL,        
  RoleID INT NOT NULL,                    
  CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP, 
  FOREIGN KEY (RoleID) REFERENCES Roles(RoleID) 
);

-- NHÓM 2: GÓI THÀNH VIÊN & THANH TOÁN

CREATE TABLE Memberships (
  MembershipID INT PRIMARY KEY AUTO_INCREMENT,  
  UserID INT NOT NULL,                          
  MembershipType VARCHAR(50) NOT NULL,          
  Price DECIMAL(10,2) NOT NULL,                 
  StartDate DATE NOT NULL,                      
  EndDate DATE NOT NULL,                       
  FOREIGN KEY (UserID) REFERENCES Users(UserID) 
);

CREATE TABLE PaymentTransactions (
  TransactionID INT PRIMARY KEY AUTO_INCREMENT, 
  UserID INT NOT NULL,                          
  MembershipID INT NOT NULL,                   
  PaymentDate DATETIME DEFAULT CURRENT_TIMESTAMP, 
  Amount DECIMAL(10,2) NOT NULL,               
  PaymentMethod VARCHAR(50) NOT NULL,           
  FOREIGN KEY (UserID) REFERENCES Users(UserID),
  FOREIGN KEY (MembershipID) REFERENCES Memberships(MembershipID) 
);

-- NHÓM 3: HỒ SƠ TRẺ EM & THEO DÕI SỨC KHỎE

CREATE TABLE ChildProfiles (
  ChildID INT PRIMARY KEY AUTO_INCREMENT,  
  UserID INT NOT NULL,                     
  ChildName VARCHAR(100) NOT NULL,         
  DateOfBirth DATE NOT NULL,               
  Gender VARCHAR(10) NOT NULL,             
  FOREIGN KEY (UserID) REFERENCES Users(UserID) 
);

CREATE TABLE GrowthRecords (
  RecordID INT PRIMARY KEY AUTO_INCREMENT, 
  ChildID INT NOT NULL,                    
  RecordDate DATE NOT NULL,                
  HeightCm DECIMAL(5,2) NOT NULL,          
  WeightKg DECIMAL(5,2) NOT NULL,          
  BMI DECIMAL(4,2) NOT NULL,               
  FOREIGN KEY (ChildID) REFERENCES ChildProfiles(ChildID) 
);

-- NHÓM 4: TƯ VẤN & PHẢN HỒI

CREATE TABLE Consultations (
  ConsultationID INT PRIMARY KEY AUTO_INCREMENT, 
  UserID INT NOT NULL,                           
  DoctorID INT NOT NULL,                         
  ChildID INT NOT NULL,                          
  RequestDate DATETIME DEFAULT CURRENT_TIMESTAMP,
  Message TEXT NOT NULL,                         
  Status VARCHAR(20) DEFAULT 'Pending',         
  FOREIGN KEY (UserID) REFERENCES Users(UserID),
  FOREIGN KEY (DoctorID) REFERENCES Users(UserID),
  FOREIGN KEY (ChildID) REFERENCES ChildProfiles(ChildID)
);

-- NHÓM 5: BLOG & HỖ TRỢ

CREATE TABLE BlogPosts (
  PostID INT PRIMARY KEY AUTO_INCREMENT, 
  AuthorUserID INT NOT NULL,              
  Title VARCHAR(255) NOT NULL,           
  Content TEXT NOT NULL,                 
  PublishedDate DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (AuthorUserID) REFERENCES Users(UserID)
);

CREATE TABLE FAQ (
  FAQID INT PRIMARY KEY AUTO_INCREMENT, 
  Question TEXT NOT NULL,               
  Answer TEXT NOT NULL,                 
  CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP
);