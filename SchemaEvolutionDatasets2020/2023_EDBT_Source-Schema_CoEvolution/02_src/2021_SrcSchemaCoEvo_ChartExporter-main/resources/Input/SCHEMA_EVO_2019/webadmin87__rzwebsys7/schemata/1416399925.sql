/*
Navicat PGSQL Data Transfer

Source Server         : webdev
Source Server Version : 90302
Source Host           : 192.168.56.101:5432
Source Database       : labris
Source Schema         : public

Target Server Type    : PGSQL
Target Server Version : 90302
File Encoding         : 65001

Date: 2014-11-19 16:22:21
*/


-- ----------------------------
-- Table structure for geo_countrys
-- ----------------------------
DROP TABLE IF EXISTS "geo_countrys";
CREATE TABLE "geo_countrys" (
"id" int4 DEFAULT nextval('geo_countrys_id_seq'::regclass) NOT NULL,
"title" varchar(255) COLLATE "default" NOT NULL,
"title2" varchar(255) COLLATE "default" NOT NULL,
"active" bool DEFAULT true NOT NULL,
"author_id" int4 DEFAULT 0 NOT NULL,
"created_at" timestamp(6) DEFAULT now() NOT NULL,
"updated_at" timestamptz(6) DEFAULT now() NOT NULL
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of geo_countrys
-- ----------------------------

-- ----------------------------
-- Table structure for geo_np
-- ----------------------------
DROP TABLE IF EXISTS "geo_np";
CREATE TABLE "geo_np" (
"id" int4 DEFAULT nextval('geo_np_id_seq'::regclass) NOT NULL,
"rajon_id" int4 NOT NULL,
"clean_title" varchar(255) COLLATE "default" NOT NULL,
"title" varchar(255) COLLATE "default" NOT NULL,
"title2" varchar(255) COLLATE "default" NOT NULL,
"type" varchar(16) COLLATE "default" NOT NULL,
"type_ext" varchar(255) COLLATE "default" NOT NULL,
"code" varchar(255) COLLATE "default" NOT NULL,
"active" bool DEFAULT true NOT NULL,
"author_id" int4 DEFAULT 0 NOT NULL,
"created_at" timestamp(6) DEFAULT now() NOT NULL,
"updated_at" timestamptz(6) DEFAULT now() NOT NULL
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of geo_np
-- ----------------------------

-- ----------------------------
-- Table structure for geo_rajon
-- ----------------------------
DROP TABLE IF EXISTS "geo_rajon";
CREATE TABLE "geo_rajon" (
"id" int4 DEFAULT nextval('geo_rajon_id_seq'::regclass) NOT NULL,
"region_id" int4 NOT NULL,
"clean_title" varchar(255) COLLATE "default" NOT NULL,
"title" varchar(255) COLLATE "default" NOT NULL,
"title2" varchar(255) COLLATE "default" NOT NULL,
"type" varchar(16) COLLATE "default" NOT NULL,
"type_ext" varchar(255) COLLATE "default" NOT NULL,
"code" varchar(255) COLLATE "default" NOT NULL,
"active" bool DEFAULT true NOT NULL,
"author_id" int4 DEFAULT 0 NOT NULL,
"created_at" timestamp(6) DEFAULT now() NOT NULL,
"updated_at" timestamptz(6) DEFAULT now() NOT NULL
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of geo_rajon
-- ----------------------------

-- ----------------------------
-- Table structure for geo_region
-- ----------------------------
DROP TABLE IF EXISTS "geo_region";
CREATE TABLE "geo_region" (
"id" int4 DEFAULT nextval('geo_region_id_seq'::regclass) NOT NULL,
"country_id" int4 NOT NULL,
"clean_title" varchar(255) COLLATE "default" NOT NULL,
"title" varchar(255) COLLATE "default" NOT NULL,
"title2" varchar(255) COLLATE "default" NOT NULL,
"type" varchar(255) COLLATE "default" NOT NULL,
"type_ext" varchar(255) COLLATE "default" NOT NULL,
"code" int4 NOT NULL,
"active" bool DEFAULT true NOT NULL,
"author_id" int4 DEFAULT 0 NOT NULL,
"created_at" timestamp(6) DEFAULT now() NOT NULL,
"updated_at" timestamptz(6) DEFAULT now() NOT NULL
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of geo_region
-- ----------------------------

-- ----------------------------
-- Table structure for geo_street
-- ----------------------------
DROP TABLE IF EXISTS "geo_street";
CREATE TABLE "geo_street" (
"id" int4 DEFAULT nextval('geo_street_id_seq'::regclass) NOT NULL,
"region_id" int4 DEFAULT 0 NOT NULL,
"rajon_id" int4 DEFAULT 0 NOT NULL,
"clean_title" varchar(255) COLLATE "default",
"title" varchar(255) COLLATE "default" NOT NULL,
"title2" varchar(255) COLLATE "default",
"type" varchar(16) COLLATE "default",
"type_ext" varchar(255) COLLATE "default",
"code" varchar(255) COLLATE "default",
"active" bool DEFAULT true NOT NULL,
"author_id" int4 DEFAULT 0 NOT NULL,
"created_at" timestamp(6) DEFAULT now() NOT NULL,
"updated_at" timestamptz(6) DEFAULT now() NOT NULL
)
WITH (OIDS=FALSE)

;
