/*
SQLyog Ultimate v11.11 (32 bit)
MySQL - 8.0.46-0ubuntu0.24.04.2 : Database - gps_tracking
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
USE `gps_tracking`;

/*Table structure for table `DATABASECHANGELOG` */

DROP TABLE IF EXISTS `DATABASECHANGELOG`;

CREATE TABLE `DATABASECHANGELOG` (
  `ID` varchar(255) NOT NULL,
  `AUTHOR` varchar(255) NOT NULL,
  `FILENAME` varchar(255) NOT NULL,
  `DATEEXECUTED` datetime NOT NULL,
  `ORDEREXECUTED` int NOT NULL,
  `EXECTYPE` varchar(10) NOT NULL,
  `MD5SUM` varchar(35) DEFAULT NULL,
  `DESCRIPTION` varchar(255) DEFAULT NULL,
  `COMMENTS` varchar(255) DEFAULT NULL,
  `TAG` varchar(255) DEFAULT NULL,
  `LIQUIBASE` varchar(20) DEFAULT NULL,
  `CONTEXTS` varchar(255) DEFAULT NULL,
  `LABELS` varchar(255) DEFAULT NULL,
  `DEPLOYMENT_ID` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `DATABASECHANGELOG` */

insert  into `DATABASECHANGELOG`(`ID`,`AUTHOR`,`FILENAME`,`DATEEXECUTED`,`ORDEREXECUTED`,`EXECTYPE`,`MD5SUM`,`DESCRIPTION`,`COMMENTS`,`TAG`,`LIQUIBASE`,`CONTEXTS`,`LABELS`,`DEPLOYMENT_ID`) values ('changelog-4.0-clean','author','changelog-4.0-clean','2026-05-22 07:42:10',1,'EXECUTED','9:29260b7c580835a4006cb8c8303f753e','createTable tableName=tc_attributes; createTable tableName=tc_calendars; createTable tableName=tc_commands; createTable tableName=tc_device_attribute; createTable tableName=tc_device_command; createTable tableName=tc_device_driver; createTable tab...','',NULL,'4.23.2',NULL,NULL,'9435720500'),('changelog-4.0-clean-common','author','changelog-4.0-clean','2026-05-22 07:42:10',2,'EXECUTED','9:9106689cc508433f83e5bf7885bfc276','addForeignKeyConstraint baseTableName=tc_groups, constraintName=fk_groups_groupid, referencedTableName=tc_groups; addForeignKeyConstraint baseTableName=tc_user_user, constraintName=fk_user_user_manageduserid, referencedTableName=tc_users','',NULL,'4.23.2',NULL,NULL,'9435720500'),('changelog-3.3','author','changelog-3.3','2026-05-22 07:42:10',3,'MARK_RAN','9:bb6fa4c9a558aab1c22ff673e73a2df7','createTable tableName=users; addUniqueConstraint constraintName=uk_user_email, tableName=users; createTable tableName=devices; addUniqueConstraint constraintName=uk_device_uniqueid, tableName=devices; createTable tableName=user_device; addForeignK...','',NULL,'4.23.2',NULL,NULL,'9435720500'),('changelog-3.5','author','changelog-3.5','2026-05-22 07:42:10',4,'MARK_RAN','9:b8197a0f7dcedcda83f17ee28b866c12','createTable tableName=groups; createTable tableName=user_group; addForeignKeyConstraint baseTableName=user_group, constraintName=fk_user_group_userid, referencedTableName=users; addForeignKeyConstraint baseTableName=user_group, constraintName=fk_u...','',NULL,'4.23.2',NULL,NULL,'9435720500'),('changelog-3.6','author','changelog-3.6','2026-05-22 07:42:10',5,'MARK_RAN','9:3d062403b1f4e179f39abe9823dc8778','createTable tableName=events; addForeignKeyConstraint baseTableName=events, constraintName=fk_event_deviceid, referencedTableName=devices; addColumn tableName=devices; createTable tableName=geofences; createTable tableName=user_geofence; addForeig...','',NULL,'4.23.2',NULL,NULL,'9435720500'),('changelog-3.7','author','changelog-3.7','2026-05-22 07:42:10',6,'MARK_RAN','9:921bc1885dbecd66ad680c05cd788f1d','update tableName=devices; addForeignKeyConstraint baseTableName=devices, constraintName=fk_device_group_groupid, referencedTableName=groups; update tableName=groups; addColumn tableName=devices; dropColumn columnName=motion, tableName=devices; dro...','',NULL,'4.23.2',NULL,NULL,'9435720500'),('changelog-3.7-notmssql','author','changelog-3.7','2026-05-22 07:42:10',7,'MARK_RAN','9:24714339932615af4edc04c5b1fef3f5','addForeignKeyConstraint baseTableName=groups, constraintName=fk_group_group_groupid, referencedTableName=groups','',NULL,'4.23.2',NULL,NULL,'9435720500'),('changelog-3.8','author','changelog-3.8','2026-05-22 07:42:10',8,'MARK_RAN','9:64bcb39340c067a96dab11bf92c6992e','createTable tableName=attribute_aliases; addForeignKeyConstraint baseTableName=attribute_aliases, constraintName=fk_attribute_aliases_deviceid, referencedTableName=devices; addUniqueConstraint constraintName=uk_deviceid_attribute, tableName=attrib...','',NULL,'4.23.2',NULL,NULL,'9435720500'),('changelog-3.9','author','changelog-3.9','2026-05-22 07:42:10',9,'MARK_RAN','9:bdafab236dec1eb35711f3389037d9af','addColumn tableName=notifications; update tableName=notifications; update tableName=notifications; update tableName=notifications; update tableName=notifications','',NULL,'4.23.2',NULL,NULL,'9435720500'),('changelog-3.10','author','changelog-3.10','2026-05-22 07:42:10',10,'MARK_RAN','9:9c4224af73f728709435296f77c7ef43','createTable tableName=calendars; createTable tableName=user_calendar; addForeignKeyConstraint baseTableName=user_calendar, constraintName=fk_user_calendar_userid, referencedTableName=users; addForeignKeyConstraint baseTableName=user_calendar, cons...','',NULL,'4.23.2',NULL,NULL,'9435720500'),('changelog-3.10-notmssql','author','changelog-3.10','2026-05-22 07:42:10',11,'MARK_RAN','9:929670374dee7d507efb1a9e48de33f1','addForeignKeyConstraint baseTableName=user_user, constraintName=fk_user_user_manageduserid, referencedTableName=users','',NULL,'4.23.2',NULL,NULL,'9435720500'),('changelog-3.10-mssql','author','changelog-3.10','2026-05-22 07:42:10',12,'MARK_RAN','9:7cf543f3642b34b0721e028f7b707ded','sql','',NULL,'4.23.2',NULL,NULL,'9435720500'),('changelog-3.7-mssql','author','changelog-3.10','2026-05-22 07:42:10',13,'MARK_RAN','9:8161fe3a60d8f09de3b8e66c0d13df12','sql','',NULL,'4.23.2',NULL,NULL,'9435720500'),('changelog-3.11','author','changelog-3.11','2026-05-22 07:42:10',14,'MARK_RAN','9:acb21929570584649f579269f1fefd46','addColumn tableName=users; addColumn tableName=notifications; addColumn tableName=server; addColumn tableName=server; addColumn tableName=users','',NULL,'4.23.2',NULL,NULL,'9435720500'),('changelog-3.12','author','changelog-3.12','2026-05-22 07:42:10',15,'MARK_RAN','9:ac21f242f3a412cd5195538dd3301acb','addColumn tableName=statistics; createTable tableName=attributes; createTable tableName=user_attribute; addForeignKeyConstraint baseTableName=user_attribute, constraintName=fk_user_attribute_userid, referencedTableName=users; addForeignKeyConstrai...','',NULL,'4.23.2',NULL,NULL,'9435720500'),('changelog-3.12-notmssql','author','changelog-3.12','2026-05-22 07:42:10',16,'MARK_RAN','9:aa13c3285a22ddd5fa5181e70c9eed4a','dropForeignKeyConstraint baseTableName=groups, constraintName=fk_group_group_groupid; addForeignKeyConstraint baseTableName=groups, constraintName=fk_groups_groupid, referencedTableName=groups','',NULL,'4.23.2',NULL,NULL,'9435720500'),('changelog-3.12-pgsql','author','changelog-3.12','2026-05-22 07:42:11',17,'MARK_RAN','9:c82f089f061203d278f3fa7e3eee357c','dropColumn columnName=data, tableName=calendars; addColumn tableName=calendars','',NULL,'4.23.2',NULL,NULL,'9435720500'),('changelog-3.14','author','changelog-3.14','2026-05-22 07:42:11',18,'MARK_RAN','9:99f06473e278cb4bac143355370dbb5f','createTable tableName=drivers; addUniqueConstraint constraintName=uk_driver_uniqueid, tableName=drivers; createTable tableName=user_driver; addForeignKeyConstraint baseTableName=user_driver, constraintName=fk_user_driver_userid, referencedTableNam...','',NULL,'4.23.2',NULL,NULL,'9435720500'),('changelog-3.15','author','changelog-3.15','2026-05-22 07:42:11',19,'MARK_RAN','9:df24f9c7ea28977c8b7605330ab00c79','dropForeignKeyConstraint baseTableName=attribute_aliases, constraintName=fk_attribute_aliases_deviceid; dropUniqueConstraint constraintName=uk_deviceid_attribute, tableName=attribute_aliases; dropTable tableName=attribute_aliases; dropColumn colum...','',NULL,'4.23.2',NULL,NULL,'9435720500'),('changelog-3.16','author','changelog-3.16','2026-05-22 07:42:11',20,'MARK_RAN','9:56c004387993bc290cafab00700a2e0d','addColumn tableName=devices; addColumn tableName=users; addColumn tableName=servers; addColumn tableName=notifications; addForeignKeyConstraint baseTableName=notifications, constraintName=fk_notification_calendar_calendarid, referencedTableName=ca...','',NULL,'4.23.2',NULL,NULL,'9435720500'),('changelog-3.3-admin','author','changelog-3.17','2026-05-22 07:42:11',21,'MARK_RAN','9:a0a63100bfe3711c3063fb8946218697','renameColumn newColumnName=administrator, oldColumnName=admin, tableName=users','',NULL,'4.23.2',NULL,NULL,'9435720500'),('changelog-3.17','author','changelog-3.17','2026-05-22 07:42:11',22,'MARK_RAN','9:27de05645cf3aeb7886a92e30f4a9e29','addColumn tableName=events; createTable tableName=maintenances; createTable tableName=user_maintenance; addForeignKeyConstraint baseTableName=user_maintenance, constraintName=fk_user_maintenance_userid, referencedTableName=users; addForeignKeyCons...','',NULL,'4.23.2',NULL,NULL,'9435720500'),('changelog-4.0-pre','author','changelog-4.0','2026-05-22 07:42:11',23,'MARK_RAN','9:a211f8f9310477e68b78aad3b8df31ab','addColumn tableName=notifications','',NULL,'4.23.2',NULL,NULL,'9435720500'),('changelog-4.0-common','author','changelog-4.0','2026-05-22 07:42:11',24,'MARK_RAN','9:3af985512945bd0654f0a2354de7706a','update tableName=notifications; update tableName=notifications; update tableName=notifications; update tableName=notifications; update tableName=notifications; update tableName=notifications; update tableName=notifications','',NULL,'4.23.2',NULL,NULL,'9435720500'),('changelog-4.0-pg','author','changelog-4.0','2026-05-22 07:42:11',25,'MARK_RAN','9:1c341fc1d4fd9cfa31d01f217f3d762a','update tableName=notifications; update tableName=notifications; update tableName=notifications; update tableName=notifications; update tableName=notifications; update tableName=notifications; update tableName=notifications','',NULL,'4.23.2',NULL,NULL,'9435720500'),('changelog-4.0','author','changelog-4.0','2026-05-22 07:42:11',26,'MARK_RAN','9:5a01fa7b7073ce47885e27000842d2c7','dropDefaultValue columnName=web, tableName=notifications; dropColumn columnName=web, tableName=notifications; dropDefaultValue columnName=mail, tableName=notifications; dropColumn columnName=mail, tableName=notifications; dropDefaultValue columnNa...','',NULL,'4.23.2',NULL,NULL,'9435720500'),('changelog-4.0-renaming','author','changelog-4.0','2026-05-22 07:42:11',27,'MARK_RAN','9:bbf19e8434a012975637564e6f6de096','renameTable newTableName=tc_attributes, oldTableName=attributes; renameTable newTableName=tc_calendars, oldTableName=calendars; renameTable newTableName=tc_commands, oldTableName=commands; renameTable newTableName=tc_device_attribute, oldTableName...','',NULL,'4.23.2',NULL,NULL,'9435720500'),('changelog-4.1-mssql','author','changelog-4.1','2026-05-22 07:42:11',28,'MARK_RAN','9:0b4cd69b7025008e34cc0b8439f1d905','sql; sql; sql; sql','',NULL,'4.23.2',NULL,NULL,'9435720500'),('changelog-4.7','author','changelog-4.7','2026-05-22 07:42:11',29,'EXECUTED','9:828c072f51d04a38470dd96399de6233','createIndex indexName=user_device_user_id, tableName=tc_user_device; createIndex indexName=position_deviceid_fixtime, tableName=tc_positions','',NULL,'4.23.2',NULL,NULL,'9435720500'),('changelog-4.9','author','changelog-4.9','2026-05-22 07:42:11',30,'EXECUTED','9:62f4b0b8b3ec5c8746ed1ac842107e79','createIndex indexName=event_deviceid_servertime, tableName=tc_events','',NULL,'4.23.2',NULL,NULL,'9435720500'),('changelog-4.10','author','changelog-4.10','2026-05-22 07:42:11',31,'EXECUTED','9:3602f5246bfb9c2323e0ca67cfdab70a','addColumn tableName=tc_statistics','',NULL,'4.23.2',NULL,NULL,'9435720500'),('changelog-4.11','author','changelog-4.11','2026-05-22 07:42:11',32,'EXECUTED','9:e9052c48b7d99aa9738ab35ba314929f','addColumn tableName=tc_servers','',NULL,'4.23.2',NULL,NULL,'9435720500'),('changelog-4.13','author','changelog-4.13','2026-05-22 07:42:11',33,'EXECUTED','9:6feeb695221e4b844967cec335fb6aea','renameColumn newColumnName=eventtime, oldColumnName=servertime, tableName=tc_events','',NULL,'4.23.2',NULL,NULL,'9435720500'),('changelog-4.15','author','changelog-4.15','2026-05-22 07:42:12',34,'EXECUTED','9:c7e7a54391ed2e16ef5a90fd68c0f9d7','createTable tableName=tc_orders; createTable tableName=tc_user_order; addForeignKeyConstraint baseTableName=tc_user_order, constraintName=fk_user_order_userid, referencedTableName=tc_users; addForeignKeyConstraint baseTableName=tc_user_order, cons...','',NULL,'4.23.2',NULL,NULL,'9435720500'),('changelog-5.0','author','changelog-5.0','2026-05-22 07:42:12',35,'EXECUTED','9:ac3942110503f904188c67b63fc7c072','addColumn tableName=tc_servers; addColumn tableName=tc_users; renameColumn newColumnName=toaddresstmp, oldColumnName=toAddress, tableName=tc_orders; renameColumn newColumnName=fromaddresstmp, oldColumnName=fromAddress, tableName=tc_orders; renameC...','',NULL,'4.23.2',NULL,NULL,'9435720500'),('changelog-5.1','author','changelog-5.1','2026-05-22 07:42:13',36,'EXECUTED','9:82263460dd8dd7e71eba9c368bf5a74b','createIndex indexName=idx_drivers_uniqueid, tableName=tc_drivers; createIndex indexName=idx_devices_uniqueid, tableName=tc_devices; createIndex indexName=idx_users_email, tableName=tc_users; createIndex indexName=idx_users_login, tableName=tc_user...','',NULL,'4.23.2',NULL,NULL,'9435720500'),('changelog-5.2','author','changelog-5.2','2026-05-22 07:42:13',37,'EXECUTED','9:c1c7f476b08ce0a19801431add8446fd','addColumn tableName=tc_devices; addColumn tableName=tc_devices','',NULL,'4.23.2',NULL,NULL,'9435720500'),('changelog-5.3','author','changelog-5.3','2026-05-22 07:42:14',38,'EXECUTED','9:1a574cf5780301ad3488b68d7e457e27','addColumn tableName=tc_servers; addColumn tableName=tc_users; addColumn tableName=tc_devices; createTable tableName=tc_keystore; dropIndex indexName=idx_users_token, tableName=tc_users; dropColumn columnName=token, tableName=tc_users','',NULL,'4.23.2',NULL,NULL,'9435720500'),('changelog-5.4','author','changelog-5.4','2026-05-22 07:42:14',39,'EXECUTED','9:f3048803607da81d070ff76022d1020a','addColumn tableName=tc_devices; createTable tableName=tc_commands_queue; addForeignKeyConstraint baseTableName=tc_commands_queue, constraintName=fk_commands_queue_deviceid, referencedTableName=tc_devices; createIndex indexName=idx_commands_queue_d...','',NULL,'4.23.2',NULL,NULL,'9435720500'),('changelog-5.5','author','changelog-5.5','2026-05-22 07:42:14',40,'EXECUTED','9:23b37a6f82fd32497af31f093b855dc9','dropColumn columnName=description, tableName=tc_commands_queue','',NULL,'4.23.2',NULL,NULL,'9435720500'),('changelog-5.6','author','changelog-5.6','2026-05-22 07:42:15',41,'EXECUTED','9:99240a2ac8883cb74c5cba38ef5c1686','addColumn tableName=tc_devices; createTable tableName=tc_reports; addForeignKeyConstraint baseTableName=tc_reports, constraintName=fk_reports_calendarid, referencedTableName=tc_calendars; createTable tableName=tc_user_report; addForeignKeyConstrai...','',NULL,'4.23.2',NULL,NULL,'9435720500'),('changelog-5.7','author','changelog-5.7','2026-05-22 07:42:15',42,'EXECUTED','9:f2425b5cceff33f0abbe4c1ea0c18a28','addColumn tableName=tc_notifications; addForeignKeyConstraint baseTableName=tc_notifications, constraintName=fk_notifications_commandid, referencedTableName=tc_commands','',NULL,'4.23.2',NULL,NULL,'9435720500'),('changelog-5.8','author','changelog-5.8','2026-05-22 07:42:16',43,'EXECUTED','9:6700eee6204986c4db1134cf30a188d6','dropColumn columnName=geofenceids, tableName=tc_devices; addColumn tableName=tc_positions','',NULL,'4.23.2',NULL,NULL,'9435720500'),('changelog-5.9','author','changelog-5.9','2026-05-22 07:42:16',44,'EXECUTED','9:f516b72a9e6c82f09e8bbf7802884768','addColumn tableName=tc_devices; addForeignKeyConstraint baseTableName=tc_devices, constraintName=fk_devices_calendarid, referencedTableName=tc_calendars','',NULL,'4.23.2',NULL,NULL,'9435720500'),('changelog-5.10','author','changelog-5.10','2026-05-22 07:42:16',45,'EXECUTED','9:2de9e66d1f8219a42b14390dd5a5b218','addColumn tableName=tc_users','',NULL,'4.23.2',NULL,NULL,'9435720500'),('changelog-5.11','author','changelog-5.11','2026-05-22 07:42:16',46,'EXECUTED','9:f30849022d894f99ea42f93e69c00ed8','addColumn tableName=tc_users','',NULL,'4.23.2',NULL,NULL,'9435720500'),('changelog-6.2','author','changelog-6.2','2026-05-22 07:42:17',47,'EXECUTED','9:4afc10f18622be53ad650af7d23ca1e0','dropColumn columnName=twelvehourformat, tableName=tc_servers; dropColumn columnName=twelvehourformat, tableName=tc_users; addColumn tableName=tc_attributes','',NULL,'4.23.2',NULL,NULL,'9435720500'),('changelog-6.3-old','author','changelog-6.3','2026-05-22 07:42:17',48,'MARK_RAN','9:4e1d3dc09c7c412a7637461af4f40931','dropForeignKeyConstraint baseTableName=tc_events, constraintName=fk_event_deviceid; dropForeignKeyConstraint baseTableName=tc_positions, constraintName=fk_position_deviceid','',NULL,'4.23.2',NULL,NULL,'9435720500'),('changelog-6.3-new','author','changelog-6.3','2026-05-22 07:42:17',49,'EXECUTED','9:1ecbc64d93f7dcb304d5f482b04b9b56','dropForeignKeyConstraint baseTableName=tc_events, constraintName=fk_events_deviceid; dropForeignKeyConstraint baseTableName=tc_positions, constraintName=fk_positions_deviceid','',NULL,'4.23.2',NULL,NULL,'9435720500'),('changelog-6.6','author','changelog-6.6','2026-05-22 07:42:17',50,'EXECUTED','9:9de8626a90708711843aab4560a33515','addColumn tableName=tc_notifications','',NULL,'4.23.2',NULL,NULL,'9435720500');

/*Table structure for table `DATABASECHANGELOGLOCK` */

DROP TABLE IF EXISTS `DATABASECHANGELOGLOCK`;

CREATE TABLE `DATABASECHANGELOGLOCK` (
  `ID` int NOT NULL,
  `LOCKED` bit(1) NOT NULL,
  `LOCKGRANTED` datetime DEFAULT NULL,
  `LOCKEDBY` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `DATABASECHANGELOGLOCK` */

insert  into `DATABASECHANGELOGLOCK`(`ID`,`LOCKED`,`LOCKGRANTED`,`LOCKEDBY`) values (1,'\0',NULL,NULL);

/*Table structure for table `activity_log` */

DROP TABLE IF EXISTS `activity_log`;

CREATE TABLE `activity_log` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `log_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `event` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subject_id` bigint unsigned DEFAULT NULL,
  `causer_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `causer_id` bigint unsigned DEFAULT NULL,
  `properties` json DEFAULT NULL,
  `batch_uuid` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `subject` (`subject_type`,`subject_id`),
  KEY `causer` (`causer_type`,`causer_id`),
  KEY `activity_log_log_name_index` (`log_name`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `activity_log` */

insert  into `activity_log`(`id`,`log_name`,`description`,`subject_type`,`event`,`subject_id`,`causer_type`,`causer_id`,`properties`,`batch_uuid`,`created_at`,`updated_at`) values (1,'default','User created','App\\Models\\User','created',3,'App\\Models\\User',2,'{\"attributes\": {\"name\": \"Zahid\", \"role\": \"user\", \"email\": \"zhg786@gmail.com\", \"status\": \"active\", \"country_code\": \"92\"}}',NULL,'2026-05-23 19:30:10','2026-05-23 19:30:10'),(2,'admin','Created user zhg786@gmail.com','App\\Models\\User','created',3,'App\\Models\\User',2,'{\"ip\": \"182.190.218.225\", \"url\": \"http://52.58.173.39/admin/users\", \"role\": \"user\", \"method\": \"POST\", \"status\": \"active\"}',NULL,'2026-05-23 19:30:11','2026-05-23 19:30:11'),(3,'admin','Created device 867530912345678','App\\Models\\Device','created',1,'App\\Models\\User',2,'{\"ip\": \"182.190.218.225\", \"url\": \"http://52.58.173.39/admin/devices\", \"name\": \"VXL\", \"method\": \"POST\", \"status\": \"active\", \"user_id\": 3, \"device_type\": \"car\"}',NULL,'2026-05-23 19:30:39','2026-05-23 19:30:39'),(4,'admin','Created subscription for device #1','App\\Models\\Subscription','created',1,'App\\Models\\User',2,'{\"ip\": \"182.190.218.225\", \"url\": \"http://52.58.173.39/admin/subscriptions\", \"plan\": \"Basic\", \"method\": \"POST\", \"status\": \"active\", \"ends_at\": \"2028-05-31\"}',NULL,'2026-05-23 19:31:01','2026-05-23 19:31:01'),(5,'default','User updated','App\\Models\\User','updated',1,'App\\Models\\User',2,'{\"old\": {\"email\": \"admin\", \"country_code\": null}, \"attributes\": {\"email\": \"admin@traccar.com\", \"country_code\": \"\"}}',NULL,'2026-05-23 20:18:40','2026-05-23 20:18:40'),(6,'admin','Updated user admin@traccar.com','App\\Models\\User','updated',1,'App\\Models\\User',2,'{\"ip\": \"182.190.218.225\", \"url\": \"http://52.58.173.39/admin/users/1\", \"role\": \"admin\", \"method\": \"PUT\", \"status\": \"active\"}',NULL,'2026-05-23 20:18:40','2026-05-23 20:18:40'),(7,'admin','Created device 35457557','App\\Models\\Device','created',3,'App\\Models\\User',2,'{\"ip\": \"182.190.217.34\", \"url\": \"http://52.58.173.39/admin/devices\", \"name\": \"V27-Zahid\", \"method\": \"POST\", \"status\": \"active\", \"user_id\": 3, \"device_type\": \"personal\"}',NULL,'2026-05-24 03:27:08','2026-05-24 03:27:08'),(8,'admin','Created subscription for device #3','App\\Models\\Subscription','created',2,'App\\Models\\User',2,'{\"ip\": \"182.190.217.34\", \"url\": \"http://52.58.173.39/admin/subscriptions\", \"plan\": \"Premium\", \"method\": \"POST\", \"status\": \"active\", \"ends_at\": \"2028-12-31\"}',NULL,'2026-05-24 03:27:35','2026-05-24 03:27:35'),(9,'admin','Updated device 45690099999999 status','App\\Models\\Device','updated',2,'App\\Models\\User',2,'{\"ip\": \"182.190.216.64\", \"url\": \"http://52.58.173.39/admin/devices/2/toggle-status\", \"method\": \"PATCH\", \"status\": \"inactive\"}',NULL,'2026-05-24 04:57:59','2026-05-24 04:57:59'),(10,'admin','Updated device 867530912345678 status','App\\Models\\Device','updated',1,'App\\Models\\User',2,'{\"ip\": \"182.190.216.64\", \"url\": \"http://52.58.173.39/admin/devices/1/toggle-status\", \"method\": \"PATCH\", \"status\": \"inactive\"}',NULL,'2026-05-24 04:58:00','2026-05-24 04:58:00'),(11,'admin','Created device 86059236','App\\Models\\Device','created',4,'App\\Models\\User',2,'{\"ip\": \"182.190.218.173\", \"url\": \"http://52.58.173.39/admin/devices\", \"name\": \"Zakir Device\", \"method\": \"POST\", \"status\": \"active\", \"user_id\": 3, \"device_type\": \"personal\"}',NULL,'2026-05-24 06:04:48','2026-05-24 06:04:48'),(12,'admin','Created subscription for device #4','App\\Models\\Subscription','created',3,'App\\Models\\User',2,'{\"ip\": \"182.190.218.173\", \"url\": \"http://52.58.173.39/admin/subscriptions\", \"plan\": \"Standard\", \"method\": \"POST\", \"status\": \"active\", \"ends_at\": \"2027-12-31\"}',NULL,'2026-05-24 06:05:17','2026-05-24 06:05:17'),(13,'default','User updated','App\\Models\\User','updated',3,'App\\Models\\User',3,'{\"old\": {\"country_code\": \"92\"}, \"attributes\": {\"country_code\": \"+213\"}}',NULL,'2026-05-29 03:47:26','2026-05-29 03:47:26'),(14,'default','User updated','App\\Models\\User','updated',3,'App\\Models\\User',3,'{\"old\": {\"country_code\": \"+213\"}, \"attributes\": {\"country_code\": \"+92\"}}',NULL,'2026-05-29 03:47:37','2026-05-29 03:47:37'),(15,'default','User created','App\\Models\\User','created',4,'App\\Models\\User',2,'{\"attributes\": {\"name\": \"Corporate\", \"role\": \"client\", \"email\": \"corporate@user.com\", \"status\": \"active\", \"country_code\": \"+966\"}}',NULL,'2026-05-29 05:49:04','2026-05-29 05:49:04'),(16,'admin','Created user corporate@user.com','App\\Models\\User','created',4,'App\\Models\\User',2,'{\"ip\": \"182.190.216.96\", \"url\": \"https://falconeyegps.com/admin/users\", \"role\": \"client\", \"panel\": \"admin\", \"method\": \"POST\", \"status\": \"active\", \"category\": \"user\", \"client_id\": 1, \"actor_role\": \"super_admin\", \"client_name\": \"Corporate\"}',NULL,'2026-05-29 05:49:04','2026-05-29 05:49:04'),(17,'default','User updated','App\\Models\\User','updated',4,'App\\Models\\User',2,'{\"old\": {\"role\": \"client\"}, \"attributes\": {\"role\": \"user\"}}',NULL,'2026-05-29 05:50:44','2026-05-29 05:50:44'),(18,'admin','Updated user corporate@user.com','App\\Models\\User','updated',4,'App\\Models\\User',2,'{\"ip\": \"182.190.216.96\", \"url\": \"https://falconeyegps.com/admin/users/4\", \"role\": \"user\", \"panel\": \"admin\", \"method\": \"PUT\", \"status\": \"active\", \"category\": \"user\", \"client_id\": 1, \"actor_role\": \"super_admin\", \"client_name\": \"Corporate\"}',NULL,'2026-05-29 05:50:44','2026-05-29 05:50:44'),(19,'admin','Updated user corporate@user.com','App\\Models\\User','updated',4,'App\\Models\\User',2,'{\"ip\": \"182.190.216.96\", \"url\": \"https://falconeyegps.com/admin/users/4\", \"role\": \"user\", \"panel\": \"admin\", \"method\": \"PUT\", \"status\": \"active\", \"category\": \"user\", \"client_id\": 1, \"actor_role\": \"super_admin\", \"client_name\": \"Corporate\"}',NULL,'2026-05-29 05:51:58','2026-05-29 05:51:58'),(20,'default','User deleted','App\\Models\\User','deleted',4,'App\\Models\\User',2,'{\"old\": {\"name\": \"Corporate\", \"role\": \"user\", \"email\": \"corporate@user.com\", \"status\": \"active\", \"country_code\": \"+966\"}}',NULL,'2026-05-29 05:58:43','2026-05-29 05:58:43'),(21,'admin','Deleted user corporate@user.com',NULL,'deleted',NULL,'App\\Models\\User',2,'{\"ip\": \"182.190.216.96\", \"url\": \"https://falconeyegps.com/admin/users/4\", \"email\": \"corporate@user.com\", \"panel\": \"admin\", \"method\": \"DELETE\", \"category\": \"general\", \"client_id\": 1, \"actor_role\": \"super_admin\", \"client_name\": \"Corporate\"}',NULL,'2026-05-29 05:58:43','2026-05-29 05:58:43'),(22,'default','User deleted','App\\Models\\User','deleted',3,'App\\Models\\User',2,'{\"old\": {\"name\": \"Zahid\", \"role\": \"user\", \"email\": \"zhg786@gmail.com\", \"status\": \"active\", \"country_code\": \"+92\"}}',NULL,'2026-05-29 05:58:47','2026-05-29 05:58:47'),(23,'admin','Deleted user zhg786@gmail.com',NULL,'deleted',NULL,'App\\Models\\User',2,'{\"ip\": \"182.190.216.96\", \"url\": \"https://falconeyegps.com/admin/users/3\", \"email\": \"zhg786@gmail.com\", \"panel\": \"admin\", \"method\": \"DELETE\", \"category\": \"general\", \"actor_role\": \"super_admin\"}',NULL,'2026-05-29 05:58:47','2026-05-29 05:58:47'),(24,'admin','Deleted device 86059236',NULL,'deleted',NULL,'App\\Models\\User',2,'{\"ip\": \"182.190.216.96\", \"url\": \"https://falconeyegps.com/admin/devices/4\", \"imei\": \"86059236\", \"panel\": \"admin\", \"method\": \"DELETE\", \"category\": \"general\", \"actor_role\": \"super_admin\"}',NULL,'2026-05-29 05:58:58','2026-05-29 05:58:58'),(25,'admin','Deleted device 35457557',NULL,'deleted',NULL,'App\\Models\\User',2,'{\"ip\": \"182.190.216.96\", \"url\": \"https://falconeyegps.com/admin/devices/3\", \"imei\": \"35457557\", \"panel\": \"admin\", \"method\": \"DELETE\", \"category\": \"general\", \"actor_role\": \"super_admin\"}',NULL,'2026-05-29 05:59:00','2026-05-29 05:59:00'),(26,'admin','Deleted device 45690099999999',NULL,'deleted',NULL,'App\\Models\\User',2,'{\"ip\": \"182.190.216.96\", \"url\": \"https://falconeyegps.com/admin/devices/2\", \"imei\": \"45690099999999\", \"panel\": \"admin\", \"method\": \"DELETE\", \"category\": \"general\", \"actor_role\": \"super_admin\"}',NULL,'2026-05-29 05:59:02','2026-05-29 05:59:02'),(27,'admin','Deleted device 867530912345678',NULL,'deleted',NULL,'App\\Models\\User',2,'{\"ip\": \"182.190.216.96\", \"url\": \"https://falconeyegps.com/admin/devices/1\", \"imei\": \"867530912345678\", \"panel\": \"admin\", \"method\": \"DELETE\", \"category\": \"general\", \"actor_role\": \"super_admin\"}',NULL,'2026-05-29 05:59:04','2026-05-29 05:59:04'),(28,'admin','Deleted subscription for device #4','App\\Models\\Subscription','deleted',3,'App\\Models\\User',2,'{\"ip\": \"182.190.216.96\", \"url\": \"https://falconeyegps.com/admin/subscriptions/3\", \"panel\": \"admin\", \"method\": \"DELETE\", \"category\": \"subscription\", \"device_id\": 4, \"actor_role\": \"super_admin\"}',NULL,'2026-05-29 06:07:54','2026-05-29 06:07:54'),(29,'admin','Deleted subscription for device #3','App\\Models\\Subscription','deleted',2,'App\\Models\\User',2,'{\"ip\": \"182.190.216.96\", \"url\": \"https://falconeyegps.com/admin/subscriptions/2\", \"panel\": \"admin\", \"method\": \"DELETE\", \"category\": \"subscription\", \"device_id\": 3, \"actor_role\": \"super_admin\"}',NULL,'2026-05-29 06:07:57','2026-05-29 06:07:57'),(30,'admin','Deleted subscription for device #1','App\\Models\\Subscription','deleted',1,'App\\Models\\User',2,'{\"ip\": \"182.190.216.96\", \"url\": \"https://falconeyegps.com/admin/subscriptions/1\", \"panel\": \"admin\", \"method\": \"DELETE\", \"category\": \"subscription\", \"device_id\": 1, \"actor_role\": \"super_admin\"}',NULL,'2026-05-29 06:08:01','2026-05-29 06:08:01'),(31,'admin','Updated subscription plan Premium','App\\Models\\SubscriptionPlan','updated',3,'App\\Models\\User',2,'{\"ip\": \"182.190.216.96\", \"url\": \"https://falconeyegps.com/admin/subscription-plans/3\", \"panel\": \"admin\", \"method\": \"PUT\", \"category\": \"subscription_plan\", \"actor_role\": \"super_admin\"}',NULL,'2026-05-29 06:09:46','2026-05-29 06:09:46'),(32,'admin','Updated subscription plan Standard','App\\Models\\SubscriptionPlan','updated',2,'App\\Models\\User',2,'{\"ip\": \"182.190.216.96\", \"url\": \"https://falconeyegps.com/admin/subscription-plans/2\", \"panel\": \"admin\", \"method\": \"PUT\", \"category\": \"subscription_plan\", \"actor_role\": \"super_admin\"}',NULL,'2026-05-29 06:10:37','2026-05-29 06:10:37'),(33,'admin','subscription plan Basic','App\\Models\\SubscriptionPlan','deleted',1,'App\\Models\\User',2,'{\"ip\": \"182.190.216.96\", \"url\": \"https://falconeyegps.com/admin/subscription-plans/1\", \"name\": \"Basic\", \"panel\": \"admin\", \"method\": \"DELETE\", \"category\": \"subscription_plan\", \"actor_role\": \"super_admin\", \"subscriptions_unlinked\": 0}',NULL,'2026-05-29 06:13:16','2026-05-29 06:13:16'),(34,'admin','Updated subscription plan Premium','App\\Models\\SubscriptionPlan','updated',3,'App\\Models\\User',2,'{\"ip\": \"182.190.216.96\", \"url\": \"https://falconeyegps.com/admin/subscription-plans/3\", \"panel\": \"admin\", \"method\": \"PUT\", \"category\": \"subscription_plan\", \"actor_role\": \"super_admin\"}',NULL,'2026-05-29 06:13:45','2026-05-29 06:13:45'),(35,'default','User created','App\\Models\\User','created',5,'App\\Models\\User',2,'{\"attributes\": {\"name\": \"Falcon Eye GPS\", \"role\": \"client\", \"email\": \"company@falconeyegps.com\", \"status\": \"active\", \"country_code\": \"+92\"}}',NULL,'2026-05-29 06:30:50','2026-05-29 06:30:50'),(36,'admin','Created user company@falconeyegps.com','App\\Models\\User','created',5,'App\\Models\\User',2,'{\"ip\": \"182.190.216.96\", \"url\": \"https://falconeyegps.com/admin/users\", \"role\": \"client\", \"panel\": \"admin\", \"method\": \"POST\", \"status\": \"active\", \"category\": \"user\", \"client_id\": 2, \"actor_role\": \"super_admin\", \"client_name\": \"Falcon Eye GPS\"}',NULL,'2026-05-29 06:30:50','2026-05-29 06:30:50'),(37,'default','User created','App\\Models\\User','created',6,'App\\Models\\User',2,'{\"attributes\": {\"name\": \"Falcon Eye\", \"role\": \"super_admin\", \"email\": \"falconeye@gps.com\", \"status\": \"active\", \"country_code\": \"+966\"}}',NULL,'2026-05-29 06:32:20','2026-05-29 06:32:20'),(38,'default','User updated','App\\Models\\User','updated',6,'App\\Models\\User',2,'{\"old\": {\"role\": \"super_admin\", \"country_code\": \"+966\"}, \"attributes\": {\"role\": \"user\", \"country_code\": \"+92\"}}',NULL,'2026-05-29 06:33:25','2026-05-29 06:33:25'),(39,'admin','Updated user falconeye@gps.com','App\\Models\\User','updated',6,'App\\Models\\User',2,'{\"ip\": \"182.190.216.96\", \"url\": \"https://falconeyegps.com/admin/users/6\", \"role\": \"user\", \"panel\": \"admin\", \"method\": \"PUT\", \"status\": \"active\", \"category\": \"user\", \"client_id\": 2, \"actor_role\": \"super_admin\", \"client_name\": \"Falcon Eye GPS\"}',NULL,'2026-05-29 06:33:25','2026-05-29 06:33:25'),(40,'default','User updated','App\\Models\\User','updated',6,'App\\Models\\User',2,'{\"old\": {\"name\": \"Falcon Eye\", \"email\": \"falconeye@gps.com\"}, \"attributes\": {\"name\": \"Swift GLX\", \"email\": \"user@user.com\"}}',NULL,'2026-05-29 06:35:11','2026-05-29 06:35:11'),(41,'admin','Updated user user@user.com','App\\Models\\User','updated',6,'App\\Models\\User',2,'{\"ip\": \"182.190.216.96\", \"url\": \"https://falconeyegps.com/admin/users/6\", \"role\": \"user\", \"panel\": \"admin\", \"method\": \"PUT\", \"status\": \"active\", \"category\": \"user\", \"client_id\": 2, \"actor_role\": \"super_admin\", \"client_name\": \"Falcon Eye GPS\"}',NULL,'2026-05-29 06:35:11','2026-05-29 06:35:11'),(42,'default','User updated','App\\Models\\User','updated',6,'App\\Models\\User',2,'{\"old\": {\"name\": \"Swift GLX\", \"email\": \"user@user.com\"}, \"attributes\": {\"name\": \"Ali\", \"email\": \"ali@user.com\"}}',NULL,'2026-05-29 06:35:41','2026-05-29 06:35:41'),(43,'admin','Updated user ali@user.com','App\\Models\\User','updated',6,'App\\Models\\User',2,'{\"ip\": \"182.190.216.96\", \"url\": \"https://falconeyegps.com/admin/users/6\", \"role\": \"user\", \"panel\": \"admin\", \"method\": \"PUT\", \"status\": \"active\", \"category\": \"user\", \"client_id\": 2, \"actor_role\": \"super_admin\", \"client_name\": \"Falcon Eye GPS\"}',NULL,'2026-05-29 06:35:41','2026-05-29 06:35:41'),(44,'admin','Created stock order ORD-2026-00001','App\\Models\\DeviceStockOrder','created',1,'App\\Models\\User',2,'{\"ip\": \"182.190.218.39\", \"url\": \"https://falconeyegps.com/admin/device-stock\", \"panel\": \"admin\", \"method\": \"POST\", \"category\": \"stock\", \"quantity\": 1000, \"actor_role\": \"super_admin\"}',NULL,'2026-05-29 15:16:10','2026-05-29 15:16:10'),(45,'admin','Created stock sale invoice INV-2026-00001','App\\Models\\DeviceStockSale','created',1,'App\\Models\\User',2,'{\"ip\": \"182.190.218.39\", \"url\": \"https://falconeyegps.com/admin/device-stock-sales\", \"panel\": \"admin\", \"method\": \"POST\", \"category\": \"stock\", \"quantity\": 500, \"client_id\": 2, \"actor_role\": \"super_admin\", \"invoice_no\": \"INV-2026-00001\", \"line_total\": \"9010.00\", \"client_name\": \"Falcon Eye GPS\"}',NULL,'2026-05-29 15:20:22','2026-05-29 15:20:22'),(46,'admin','Created device 867530912345678','App\\Models\\Device','created',5,'App\\Models\\User',2,'{\"ip\": \"182.190.218.39\", \"url\": \"https://falconeyegps.com/admin/devices\", \"name\": \"Traccar\", \"panel\": \"admin\", \"method\": \"POST\", \"status\": \"active\", \"user_id\": 6, \"category\": \"device\", \"client_id\": 2, \"actor_role\": \"super_admin\", \"client_name\": \"Falcon Eye GPS\", \"device_type\": \"gps_tracker\"}',NULL,'2026-05-29 16:16:27','2026-05-29 16:16:27'),(47,'admin','Updated device 867530912345678','App\\Models\\Device','updated',5,'App\\Models\\User',2,'{\"ip\": \"182.190.218.39\", \"url\": \"https://falconeyegps.com/admin/devices/5\", \"imei\": \"867530912345678\", \"name\": \"Traccar\", \"panel\": \"admin\", \"method\": \"PUT\", \"status\": \"active\", \"user_id\": \"6\", \"category\": \"device\", \"sim_type\": \"esim\", \"client_id\": 2, \"actor_role\": \"super_admin\", \"plate_type\": \"public_transfer\", \"sim_number\": \"03000012345\", \"client_name\": \"Falcon Eye GPS\", \"device_type\": \"gps_tracker\", \"vehicle_name\": \"Swift VXL\", \"vehicle_type\": \"car\", \"vehicle_model\": \"Toyota Helix 2026\", \"vehicle_number\": \"ABC-1234\"}',NULL,'2026-05-29 16:28:03','2026-05-29 16:28:03'),(48,'admin','Created subscription for device #5','App\\Models\\Subscription','created',4,'App\\Models\\User',2,'{\"ip\": \"182.190.218.39\", \"url\": \"https://falconeyegps.com/admin/subscriptions\", \"plan\": \"Premium\", \"panel\": \"admin\", \"method\": \"POST\", \"status\": \"active\", \"ends_at\": \"2027-05-29\", \"category\": \"subscription\", \"client_id\": 2, \"starts_at\": \"2026-05-29\", \"actor_role\": \"super_admin\", \"client_name\": \"Falcon Eye GPS\"}',NULL,'2026-05-29 16:29:37','2026-05-29 16:29:37'),(49,'admin','Deleted subscription for device #5','App\\Models\\Subscription','deleted',4,'App\\Models\\User',2,'{\"ip\": \"182.190.217.225\", \"url\": \"https://falconeyegps.com/admin/subscriptions/4\", \"panel\": \"admin\", \"method\": \"DELETE\", \"category\": \"subscription\", \"client_id\": 2, \"device_id\": 5, \"actor_role\": \"super_admin\", \"client_name\": \"Falcon Eye GPS\"}',NULL,'2026-05-29 17:02:46','2026-05-29 17:02:46'),(50,'admin','Created subscription for device #5','App\\Models\\Subscription','created',5,'App\\Models\\User',2,'{\"ip\": \"182.190.217.225\", \"url\": \"https://falconeyegps.com/admin/subscriptions\", \"plan\": \"Premium\", \"panel\": \"admin\", \"method\": \"POST\", \"status\": \"active\", \"ends_at\": \"2027-05-29\", \"category\": \"subscription\", \"client_id\": 2, \"starts_at\": \"2026-05-29\", \"actor_role\": \"super_admin\", \"client_name\": \"Falcon Eye GPS\"}',NULL,'2026-05-29 17:03:20','2026-05-29 17:03:20'),(51,'admin','Updated subscription for device #5','App\\Models\\Subscription','updated',5,'App\\Models\\User',2,'{\"ip\": \"182.190.217.225\", \"url\": \"https://falconeyegps.com/admin/subscriptions/5\", \"plan\": \"Premium\", \"panel\": \"admin\", \"method\": \"PUT\", \"status\": \"active\", \"ends_at\": \"2027-05-29\", \"category\": \"subscription\", \"client_id\": 2, \"starts_at\": \"2026-05-29\", \"actor_role\": \"super_admin\", \"client_name\": \"Falcon Eye GPS\"}',NULL,'2026-05-29 17:05:50','2026-05-29 17:05:50'),(52,'default','User created','App\\Models\\User','created',7,'App\\Models\\User',2,'{\"attributes\": {\"name\": \"V27\", \"role\": \"user\", \"email\": \"v27@gmail.com\", \"status\": \"active\", \"country_code\": \"+92\"}}',NULL,'2026-05-30 01:50:37','2026-05-30 01:50:37'),(53,'admin','Created user v27@gmail.com','App\\Models\\User','created',7,'App\\Models\\User',2,'{\"ip\": \"182.190.217.225\", \"url\": \"https://falconeyegps.com/admin/users\", \"role\": \"user\", \"panel\": \"admin\", \"method\": \"POST\", \"status\": \"active\", \"category\": \"user\", \"client_id\": 2, \"actor_role\": \"super_admin\", \"client_name\": \"Falcon Eye GPS\"}',NULL,'2026-05-30 01:50:37','2026-05-30 01:50:37'),(54,'admin','Created device 4089440001','App\\Models\\Device','created',6,'App\\Models\\User',2,'{\"ip\": \"182.190.217.225\", \"url\": \"https://falconeyegps.com/admin/devices\", \"name\": \"v27\", \"panel\": \"admin\", \"method\": \"POST\", \"status\": \"active\", \"user_id\": 7, \"category\": \"device\", \"client_id\": 2, \"actor_role\": \"super_admin\", \"client_name\": \"Falcon Eye GPS\", \"device_type\": \"gps_tracker\"}',NULL,'2026-05-30 01:52:00','2026-05-30 01:52:00'),(55,'admin','Created subscription for device #6','App\\Models\\Subscription','created',6,'App\\Models\\User',2,'{\"ip\": \"182.190.217.225\", \"url\": \"https://falconeyegps.com/admin/subscriptions\", \"plan\": \"Premium\", \"panel\": \"admin\", \"method\": \"POST\", \"status\": \"active\", \"ends_at\": \"2027-05-30\", \"category\": \"subscription\", \"client_id\": 2, \"starts_at\": \"2026-05-30\", \"actor_role\": \"super_admin\", \"client_name\": \"Falcon Eye GPS\"}',NULL,'2026-05-30 01:53:09','2026-05-30 01:53:09'),(56,'admin','Updated subscription for device #6','App\\Models\\Subscription','updated',6,'App\\Models\\User',2,'{\"ip\": \"182.190.217.225\", \"url\": \"https://falconeyegps.com/admin/subscriptions/6\", \"plan\": \"Premium\", \"panel\": \"admin\", \"method\": \"PUT\", \"status\": \"active\", \"ends_at\": \"2027-05-29\", \"category\": \"subscription\", \"client_id\": 2, \"starts_at\": \"2026-05-29\", \"actor_role\": \"super_admin\", \"client_name\": \"Falcon Eye GPS\"}',NULL,'2026-05-30 02:11:28','2026-05-30 02:11:28'),(57,'admin','Updated device 867530912345678','App\\Models\\Device','updated',5,'App\\Models\\User',2,'{\"ip\": \"182.190.217.225\", \"url\": \"https://falconeyegps.com/admin/devices/5\", \"imei\": \"867530912345678\", \"name\": \"Vehicle\", \"panel\": \"admin\", \"method\": \"PUT\", \"status\": \"active\", \"user_id\": \"6\", \"category\": \"device\", \"sim_type\": \"esim\", \"client_id\": 2, \"actor_role\": \"super_admin\", \"plate_type\": \"public_transfer\", \"sim_number\": \"03000012345\", \"client_name\": \"Falcon Eye GPS\", \"device_type\": \"gps_tracker\", \"vehicle_name\": \"Swift VXL\", \"vehicle_type\": \"car\", \"vehicle_model\": \"Toyota Helix 2026\", \"vehicle_number\": \"ABC-1234\"}',NULL,'2026-05-30 02:15:43','2026-05-30 02:15:43'),(58,'default','User created','App\\Models\\User','created',8,NULL,NULL,'{\"attributes\": {\"name\": \"fdgfd dfgd\", \"role\": \"user\", \"email\": \"meltunutru@necub.com\", \"status\": \"active\", \"country_code\": \"+1\"}}',NULL,'2026-05-30 15:45:48','2026-05-30 15:45:48'),(59,'default','New user registered',NULL,NULL,NULL,'App\\Models\\User',8,'{\"type\": \"registration_success\", \"ip_address\": \"49.206.118.213\", \"user_agent\": \"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36\", \"recaptcha_score\": 0.9, \"recaptcha_skipped\": false}',NULL,'2026-05-30 15:45:48','2026-05-30 15:45:48'),(60,'admin','Updated device 867530912345678','App\\Models\\Device','updated',5,'App\\Models\\User',2,'{\"ip\": \"182.190.218.239\", \"url\": \"https://falconeyegps.com/admin/devices/5\", \"imei\": \"867530912345678\", \"name\": \"Swift VXL\", \"panel\": \"admin\", \"method\": \"PUT\", \"status\": \"active\", \"user_id\": \"6\", \"category\": \"device\", \"sim_type\": \"esim\", \"client_id\": 2, \"actor_role\": \"super_admin\", \"plate_type\": \"public_transfer\", \"sim_number\": \"03000012345\", \"client_name\": \"Falcon Eye GPS\", \"device_type\": \"gps_tracker\", \"vehicle_name\": \"Swift VXL\", \"vehicle_type\": \"car\", \"vehicle_model\": \"Toyota Helix 2026\", \"vehicle_number\": \"ABC-1234\"}',NULL,'2026-05-30 16:09:04','2026-05-30 16:09:04'),(61,'default','User updated','App\\Models\\User','updated',2,'App\\Models\\User',2,'{\"old\": {\"email\": \"admin@admin.com\"}, \"attributes\": {\"email\": \"admin@falconeyegps.com\"}}',NULL,'2026-06-02 00:00:47','2026-06-02 00:00:47'),(62,'default','User created','App\\Models\\User','created',9,'App\\Models\\User',2,'{\"attributes\": {\"name\": \"M Umar\", \"role\": \"user\", \"email\": \"mumar@user.com\", \"status\": \"active\", \"country_code\": \"+92\"}}',NULL,'2026-06-05 02:38:28','2026-06-05 02:38:28'),(63,'admin','Created user mumar@user.com','App\\Models\\User','created',9,'App\\Models\\User',2,'{\"ip\": \"185.177.126.151\", \"url\": \"https://falconeyegps.com/admin/users\", \"role\": \"user\", \"panel\": \"admin\", \"method\": \"POST\", \"status\": \"active\", \"category\": \"user\", \"client_id\": 2, \"actor_role\": \"super_admin\", \"client_name\": \"Falcon Eye GPS\"}',NULL,'2026-06-05 02:38:28','2026-06-05 02:38:28'),(64,'admin','Created device 867530912345671','App\\Models\\Device','created',7,'App\\Models\\User',2,'{\"ip\": \"185.177.126.151\", \"url\": \"https://falconeyegps.com/admin/devices\", \"name\": \"Tracking\", \"panel\": \"admin\", \"method\": \"POST\", \"status\": \"active\", \"user_id\": 9, \"category\": \"device\", \"client_id\": 2, \"actor_role\": \"super_admin\", \"client_name\": \"Falcon Eye GPS\", \"device_type\": \"gps_tracker\"}',NULL,'2026-06-05 02:40:12','2026-06-05 02:40:12'),(65,'admin','Created subscription for device #7','App\\Models\\Subscription','created',7,'App\\Models\\User',2,'{\"ip\": \"185.177.126.151\", \"url\": \"https://falconeyegps.com/admin/subscriptions\", \"plan\": \"Premium\", \"panel\": \"admin\", \"method\": \"POST\", \"status\": \"active\", \"ends_at\": \"2027-06-05\", \"category\": \"subscription\", \"client_id\": 2, \"starts_at\": \"2026-06-05\", \"actor_role\": \"super_admin\", \"client_name\": \"Falcon Eye GPS\"}',NULL,'2026-06-05 02:40:35','2026-06-05 02:40:35');

/*Table structure for table `admin_client_scopes` */

DROP TABLE IF EXISTS `admin_client_scopes`;

CREATE TABLE `admin_client_scopes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `admin_user_id` bigint unsigned NOT NULL,
  `client_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admin_client_scopes_admin_user_id_client_id_unique` (`admin_user_id`,`client_id`),
  KEY `admin_client_scopes_client_id_foreign` (`client_id`),
  KEY `admin_client_scopes_admin_user_id_index` (`admin_user_id`),
  CONSTRAINT `admin_client_scopes_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `admin_client_scopes` */

/*Table structure for table `billing_invoice_lines` */

DROP TABLE IF EXISTS `billing_invoice_lines`;

CREATE TABLE `billing_invoice_lines` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `billing_invoice_id` bigint unsigned NOT NULL,
  `line_type` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` int unsigned NOT NULL DEFAULT '1',
  `unit_cost` decimal(12,2) NOT NULL DEFAULT '0.00',
  `unit_price` decimal(12,2) NOT NULL DEFAULT '0.00',
  `line_total` decimal(12,2) NOT NULL DEFAULT '0.00',
  `reference_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference_id` bigint unsigned DEFAULT NULL,
  `meta` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `billing_invoice_lines_billing_invoice_id_foreign` (`billing_invoice_id`),
  KEY `billing_invoice_lines_reference_type_reference_id_index` (`reference_type`,`reference_id`),
  CONSTRAINT `billing_invoice_lines_billing_invoice_id_foreign` FOREIGN KEY (`billing_invoice_id`) REFERENCES `billing_invoices` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `billing_invoice_lines` */

insert  into `billing_invoice_lines`(`id`,`billing_invoice_id`,`line_type`,`description`,`quantity`,`unit_cost`,`unit_price`,`line_total`,`reference_type`,`reference_id`,`meta`,`created_at`,`updated_at`) values (1,1,'subscription','Plan: Premium — Device #5',1,24.00,24.00,24.00,'App\\Models\\Subscription',4,NULL,'2026-05-29 16:29:37','2026-05-29 16:29:37'),(2,2,'subscription','Subscription: Premium',1,24.00,24.00,24.00,'App\\Models\\Subscription',4,NULL,'2026-05-29 16:29:37','2026-05-29 16:29:37'),(3,3,'subscription','Plan: Premium — Device #5',1,24.00,24.00,24.00,'App\\Models\\Subscription',5,NULL,'2026-05-29 17:03:20','2026-05-29 17:03:20'),(4,4,'subscription','Subscription: Premium',1,24.00,24.00,24.00,'App\\Models\\Subscription',5,NULL,'2026-05-29 17:03:20','2026-05-29 17:03:20'),(5,4,'device','Device: Traccar',1,16.22,16.22,16.22,'App\\Models\\Device',5,NULL,'2026-05-29 17:03:20','2026-05-29 17:03:20'),(6,5,'subscription','Plan: Premium — Device #6',1,24.00,24.00,24.00,'App\\Models\\Subscription',6,NULL,'2026-05-30 01:53:09','2026-05-30 01:53:09'),(7,6,'subscription','Subscription: Premium',1,24.00,24.00,24.00,'App\\Models\\Subscription',6,NULL,'2026-05-30 01:53:09','2026-05-30 01:53:09'),(8,6,'device','Device: v27',1,16.22,16.22,16.22,'App\\Models\\Device',6,NULL,'2026-05-30 01:53:09','2026-05-30 01:53:09'),(9,7,'subscription','Plan: Premium — Device #7',1,24.00,24.00,24.00,'App\\Models\\Subscription',7,NULL,'2026-06-05 02:40:35','2026-06-05 02:40:35'),(10,8,'subscription','Subscription: Premium',1,24.00,24.00,24.00,'App\\Models\\Subscription',7,NULL,'2026-06-05 02:40:35','2026-06-05 02:40:35'),(11,8,'device','Device: Tracking',1,16.22,16.22,16.22,'App\\Models\\Device',7,NULL,'2026-06-05 02:40:35','2026-06-05 02:40:35');

/*Table structure for table `billing_invoices` */

DROP TABLE IF EXISTS `billing_invoices`;

CREATE TABLE `billing_invoices` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `invoice_no` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `invoice_type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `client_id` bigint unsigned DEFAULT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `subscription_id` bigint unsigned DEFAULT NULL,
  `subtotal` decimal(12,2) NOT NULL DEFAULT '0.00',
  `tax_amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total` decimal(12,2) NOT NULL DEFAULT '0.00',
  `amount_paid` decimal(12,2) NOT NULL DEFAULT '0.00',
  `balance_due` decimal(12,2) NOT NULL DEFAULT '0.00',
  `currency` char(3) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'USD',
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'unpaid',
  `due_date` date DEFAULT NULL,
  `issued_at` timestamp NULL DEFAULT NULL,
  `paid_at` timestamp NULL DEFAULT NULL,
  `cancelled_at` timestamp NULL DEFAULT NULL,
  `cancelled_by` bigint unsigned DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `meta` json DEFAULT NULL,
  `created_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `billing_invoices_invoice_no_unique` (`invoice_no`),
  KEY `billing_invoices_subscription_id_foreign` (`subscription_id`),
  KEY `billing_invoices_invoice_type_status_index` (`invoice_type`,`status`),
  KEY `billing_invoices_client_id_issued_at_index` (`client_id`,`issued_at`),
  KEY `billing_invoices_user_id_index` (`user_id`),
  KEY `billing_invoices_created_by_index` (`created_by`),
  CONSTRAINT `billing_invoices_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE SET NULL,
  CONSTRAINT `billing_invoices_subscription_id_foreign` FOREIGN KEY (`subscription_id`) REFERENCES `subscriptions` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `billing_invoices` */

insert  into `billing_invoices`(`id`,`invoice_no`,`invoice_type`,`client_id`,`user_id`,`subscription_id`,`subtotal`,`tax_amount`,`total`,`amount_paid`,`balance_due`,`currency`,`status`,`due_date`,`issued_at`,`paid_at`,`cancelled_at`,`cancelled_by`,`notes`,`meta`,`created_by`,`created_at`,`updated_at`) values (1,'PINV-2026-00001','platform',2,NULL,NULL,24.00,0.00,24.00,0.00,0.00,'USD','cancelled','2026-06-28','2026-05-29 16:29:37',NULL,'2026-05-29 17:02:45',2,NULL,'{\"paired_invoice_id\": 2, \"paired_invoice_no\": \"CINV-2026-00001\"}',2,'2026-05-29 16:29:37','2026-05-29 17:02:45'),(2,'CINV-2026-00001','client',2,6,NULL,24.00,0.00,24.00,24.00,0.00,'USD','cancelled','2026-06-28','2026-05-29 16:29:37','2026-05-29 16:29:37','2026-05-29 17:02:45',2,NULL,'{\"paired_invoice_id\": 1, \"paired_invoice_no\": \"PINV-2026-00001\"}',2,'2026-05-29 16:29:37','2026-05-29 17:02:45'),(3,'PINV-2026-00002','platform',2,NULL,5,24.00,0.00,24.00,0.00,24.00,'USD','unpaid','2026-06-28','2026-05-29 17:03:20',NULL,NULL,NULL,NULL,'{\"paired_invoice_id\": 4, \"paired_invoice_no\": \"CINV-2026-00002\"}',2,'2026-05-29 17:03:20','2026-05-29 17:03:20'),(4,'CINV-2026-00002','client',2,6,5,40.22,0.00,40.22,40.22,0.00,'USD','paid','2026-06-28','2026-05-29 17:03:20','2026-05-29 17:03:20',NULL,NULL,NULL,'{\"paired_invoice_id\": 3, \"paired_invoice_no\": \"PINV-2026-00002\"}',2,'2026-05-29 17:03:20','2026-05-29 17:03:20'),(5,'PINV-2026-00003','platform',2,NULL,6,24.00,0.00,24.00,0.00,24.00,'USD','unpaid','2026-06-29','2026-05-30 01:53:09',NULL,NULL,NULL,NULL,'{\"paired_invoice_id\": 6, \"paired_invoice_no\": \"CINV-2026-00003\"}',2,'2026-05-30 01:53:09','2026-05-30 01:53:09'),(6,'CINV-2026-00003','client',2,7,6,40.22,0.00,40.22,40.22,0.00,'USD','paid','2026-06-29','2026-05-30 01:53:09','2026-05-30 01:53:09',NULL,NULL,NULL,'{\"paired_invoice_id\": 5, \"paired_invoice_no\": \"PINV-2026-00003\"}',2,'2026-05-30 01:53:09','2026-05-30 01:53:09'),(7,'PINV-2026-00004','platform',2,NULL,7,24.00,0.00,24.00,0.00,24.00,'USD','unpaid','2026-07-05','2026-06-05 02:40:35',NULL,NULL,NULL,NULL,'{\"paired_invoice_id\": 8, \"paired_invoice_no\": \"CINV-2026-00004\"}',2,'2026-06-05 02:40:35','2026-06-05 02:40:35'),(8,'CINV-2026-00004','client',2,9,7,40.22,0.00,40.22,40.22,0.00,'USD','paid','2026-07-05','2026-06-05 02:40:35','2026-06-05 02:40:35',NULL,NULL,NULL,'{\"paired_invoice_id\": 7, \"paired_invoice_no\": \"PINV-2026-00004\"}',2,'2026-06-05 02:40:35','2026-06-05 02:40:35');

/*Table structure for table `billing_payments` */

DROP TABLE IF EXISTS `billing_payments`;

CREATE TABLE `billing_payments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `billing_invoice_id` bigint unsigned NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `payment_method` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paid_at` timestamp NOT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `recorded_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `billing_payments_billing_invoice_id_foreign` (`billing_invoice_id`),
  KEY `billing_payments_recorded_by_index` (`recorded_by`),
  CONSTRAINT `billing_payments_billing_invoice_id_foreign` FOREIGN KEY (`billing_invoice_id`) REFERENCES `billing_invoices` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `billing_payments` */

insert  into `billing_payments`(`id`,`billing_invoice_id`,`amount`,`payment_method`,`reference`,`paid_at`,`notes`,`recorded_by`,`created_at`,`updated_at`) values (1,2,24.00,'Manual','Subscription form','2026-05-29 16:29:37',NULL,2,'2026-05-29 16:29:37','2026-05-29 16:29:37'),(2,4,40.22,'Manual','Subscription form','2026-05-29 17:03:20',NULL,2,'2026-05-29 17:03:20','2026-05-29 17:03:20'),(3,6,40.22,'Manual','Subscription form','2026-05-30 01:53:09',NULL,2,'2026-05-30 01:53:09','2026-05-30 01:53:09'),(4,8,40.22,'Manual','Subscription form','2026-06-05 02:40:35',NULL,2,'2026-06-05 02:40:35','2026-06-05 02:40:35');

/*Table structure for table `cache` */

DROP TABLE IF EXISTS `cache`;

CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `cache` */

insert  into `cache`(`key`,`value`,`expiration`) values ('falconeyegps-cache-device.5.inside_geofence','N;',1781211304),('falconeyegps-cache-device.7.event.gsm_weak','b:1;',1780611200),('falconeyegps-cache-device.7.inside_geofence','N;',1781260190),('falconeyegps-cache-device.7.motion_state','s:7:\"stopped\";',1780697092),('falconeyegps-cache-device.7.push_connectivity','b:1;',1780697116);

/*Table structure for table `cache_locks` */

DROP TABLE IF EXISTS `cache_locks`;

CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `cache_locks` */

/*Table structure for table `client_devices` */

DROP TABLE IF EXISTS `client_devices`;

CREATE TABLE `client_devices` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `client_id` bigint unsigned NOT NULL,
  `device_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `client_devices_client_id_device_id_unique` (`client_id`,`device_id`),
  UNIQUE KEY `client_devices_device_id_unique` (`device_id`),
  KEY `client_devices_device_id_index` (`device_id`),
  CONSTRAINT `client_devices_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `client_devices` */

insert  into `client_devices`(`id`,`client_id`,`device_id`,`created_at`,`updated_at`) values (1,2,5,'2026-05-29 16:16:27','2026-05-29 16:16:27'),(2,2,6,'2026-05-30 01:52:00','2026-05-30 01:52:00'),(3,2,7,'2026-06-05 02:40:12','2026-06-05 02:40:12');

/*Table structure for table `client_members` */

DROP TABLE IF EXISTS `client_members`;

CREATE TABLE `client_members` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `client_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `membership` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'member',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `client_members_client_id_user_id_unique` (`client_id`,`user_id`),
  KEY `client_members_user_id_index` (`user_id`),
  CONSTRAINT `client_members_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `client_members` */

insert  into `client_members`(`id`,`client_id`,`user_id`,`membership`,`created_at`,`updated_at`) values (1,1,4,'member','2026-05-29 05:49:04','2026-05-29 05:50:44'),(2,2,5,'owner','2026-05-29 06:30:50','2026-05-29 06:30:50'),(3,2,6,'member','2026-05-29 06:33:25','2026-05-29 06:33:25'),(4,2,7,'member','2026-05-30 01:50:37','2026-05-30 01:50:37'),(5,2,9,'member','2026-06-05 02:38:28','2026-06-05 02:38:28');

/*Table structure for table `clients` */

DROP TABLE IF EXISTS `clients`;

CREATE TABLE `clients` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `can_track_maps` tinyint(1) NOT NULL DEFAULT '0',
  `created_by` bigint unsigned DEFAULT NULL,
  `settings` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `clients_slug_unique` (`slug`),
  KEY `clients_status_index` (`status`),
  KEY `clients_created_by_index` (`created_by`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `clients` */

insert  into `clients`(`id`,`name`,`slug`,`status`,`can_track_maps`,`created_by`,`settings`,`created_at`,`updated_at`) values (1,'Corporate','corporate','active',0,2,NULL,'2026-05-29 05:49:04','2026-05-29 05:49:04'),(2,'Falcon Eye GPS','falcon-eye-gps','active',1,2,NULL,'2026-05-29 06:30:49','2026-05-29 06:30:49');

/*Table structure for table `contact_messages` */

DROP TABLE IF EXISTS `contact_messages`;

CREATE TABLE `contact_messages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subject` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('new','read','replied','closed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'new',
  `priority` enum('low','medium','high') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'medium',
  `ip_address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `metadata` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `contact_messages_status_priority_index` (`status`,`priority`),
  KEY `contact_messages_email_index` (`email`),
  KEY `contact_messages_created_at_index` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `contact_messages` */

insert  into `contact_messages`(`id`,`name`,`email`,`phone`,`company`,`subject`,`message`,`status`,`priority`,`ip_address`,`user_agent`,`metadata`,`created_at`,`updated_at`,`deleted_at`) values (1,'zahid','gopang@gmail.com','+92913312343433','Pupils Diary','need this system','testing','read','medium','182.190.216.70','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36','{\"referrer\": \"https://falconeyegps.com/contact\", \"timezone\": \"UTC\", \"form_source\": \"contact_page\", \"submission_time\": \"2026-05-29T04:29:52+05:00\"}','2026-05-29 04:29:52','2026-05-29 04:30:27',NULL),(2,'Richardhapse','yourmail@gmail.com','86961349949','google','Test, message - Thank you!','Test, message - Thank you!','read','medium','149.154.185.45','Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.0.0 Safari/537.36','{\"referrer\": \"http://falconeyegps.com/contact\", \"timezone\": \"UTC\", \"form_source\": \"contact_page\", \"submission_time\": \"2026-05-29T07:29:07+05:00\"}','2026-05-29 07:29:07','2026-06-01 23:37:57',NULL),(3,'Ali','asif@rocketdigitaltech.com','7532833829','Matt Hobart','Let’s Boost Your Website Traffic','Hello http://falconeyegps.com,\r\n \r\nI hope you’re doing well. I came across your business online and thought you might be interested in improving your visibility and traffic on search engines.\r\n \r\nWe specialize in helping businesses strengthen their online presence through effective SEO strategies.\r\n \r\nOnce you share your target keywords and target market, I’ll send a full proposal.\r\n \r\nWarm regards,\r\nAsif','read','medium','160.202.39.140','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36','{\"referrer\": \"http://falconeyegps.com/contact\", \"timezone\": \"UTC\", \"form_source\": \"contact_page\", \"submission_time\": \"2026-05-30T14:06:34+05:00\"}','2026-05-30 14:06:34','2026-06-01 23:37:25',NULL),(4,'Jaylan Mkt','jaylan.conley@gmail.com','2102102101','Information Technology','Free Website falconeyegps.com Design Review & Audit Offer','Hello falconeyegps.com,\r\n\r\nI noticed a few design-related issues on your website that could impact its performance and user experience.\r\n\r\nWould you like me to send a screenshot highlighting these errors? I can also prepare a detailed audit report, along with a proposal and pricing to improve your website’s design and optimize its ranking.\r\n\r\nLooking forward to your response.\r\n\r\nKind regard','read','medium','212.104.215.151','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36','{\"referrer\": \"http://falconeyegps.com/contact\", \"timezone\": \"UTC\", \"form_source\": \"contact_page\", \"submission_time\": \"2026-06-01T20:12:17+05:00\"}','2026-06-01 20:12:17','2026-06-01 23:34:15',NULL),(5,'Mark Colins','markcollins.websolutions4@gmail.com','18454479454','Digital marketing agancy','Question about your website','Hello,\r\n\r\nWe recently ran a backend analysis of your website, and the results show that several important SEO (Search Engine Optimization) steps are incomplete. Due to this, your website is currently not appearing on Google, Bing, and other search engines when searched with keywords related to your business and services.\r\n\r\nWe understand that your website was created to attract more clients and generate more business, and we want you to have the best website experience ever. Our team would be happy to assist you with improving the SEO and overall online visibility of your website and business.\r\n\r\nPlease send us your preferred time availability for a quick phone call, along with your updated contact number, and we will get in touch with you to explain how we can help fix and improve your website.\r\n\r\nLooking forward to hearing from you\r\n\r\nThanks,\r\nMark Colins','read','medium','122.162.146.74','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36','{\"referrer\": \"http://falconeyegps.com/contact\", \"timezone\": \"UTC\", \"form_source\": \"contact_page\", \"submission_time\": \"2026-06-01T22:12:34+05:00\"}','2026-06-01 22:12:34','2026-06-01 23:36:22',NULL),(6,'Serena Madsen','domains@search-falconeyegps.com','745613834','Web Search Index','Results for falconeyegps.com','Hi\r\n\r\nFeature falconeyegps.com in GoogleSearchIndex to be visible in google search results!\r\n\r\nInclude falconeyegps.com now: https://searchregister.org','read','medium','209.50.180.76','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36','{\"referrer\": \"http://falconeyegps.com/contact\", \"timezone\": \"UTC\", \"form_source\": \"contact_page\", \"submission_time\": \"2026-06-01T23:18:24+05:00\"}','2026-06-01 23:18:24','2026-06-01 23:35:49',NULL);

/*Table structure for table `device_inventory_summary` */

DROP TABLE IF EXISTS `device_inventory_summary`;

CREATE TABLE `device_inventory_summary` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `product_id` bigint unsigned NOT NULL,
  `scope` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `scope_id` bigint unsigned DEFAULT NULL,
  `total_purchased` int unsigned NOT NULL DEFAULT '0',
  `total_sold` int unsigned NOT NULL DEFAULT '0',
  `total_installed` int unsigned NOT NULL DEFAULT '0',
  `total_returned` int unsigned NOT NULL DEFAULT '0',
  `available_qty` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `device_inventory_summary_product_id_scope_scope_id_unique` (`product_id`,`scope`,`scope_id`),
  KEY `device_inventory_summary_scope_scope_id_available_qty_index` (`scope`,`scope_id`,`available_qty`),
  KEY `device_inventory_summary_product_id_index` (`product_id`),
  KEY `device_inventory_summary_scope_id_index` (`scope_id`),
  CONSTRAINT `device_inventory_summary_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `inventory_products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `device_inventory_summary` */

insert  into `device_inventory_summary`(`id`,`product_id`,`scope`,`scope_id`,`total_purchased`,`total_sold`,`total_installed`,`total_returned`,`available_qty`,`created_at`,`updated_at`) values (1,1,'warehouse',NULL,1000,500,0,0,500,'2026-05-29 15:16:10','2026-05-29 15:20:22'),(2,1,'client',2,0,0,6,1,494,'2026-05-29 15:20:22','2026-06-05 02:40:35');

/*Table structure for table `device_stock_orders` */

DROP TABLE IF EXISTS `device_stock_orders`;

CREATE TABLE `device_stock_orders` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_code` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` int unsigned NOT NULL DEFAULT '1',
  `sold_quantity` int unsigned NOT NULL DEFAULT '0',
  `device_type` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'gps_tracker',
  `brand` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `model` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `condition` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'new',
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'in_stock',
  `unit_cost` decimal(12,2) NOT NULL DEFAULT '0.00',
  `selling_price` decimal(12,2) NOT NULL DEFAULT '0.00',
  `currency` varchar(3) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'USD',
  `warehouse_location` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `supplier` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `purchase_order_ref` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `purchased_at` date DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `device_stock_orders_order_code_unique` (`order_code`),
  KEY `device_stock_orders_status_index` (`status`),
  KEY `device_stock_orders_device_type_index` (`device_type`),
  KEY `device_stock_orders_created_by_index` (`created_by`),
  KEY `device_stock_orders_sold_quantity_index` (`sold_quantity`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `device_stock_orders` */

insert  into `device_stock_orders`(`id`,`order_code`,`quantity`,`sold_quantity`,`device_type`,`brand`,`model`,`condition`,`status`,`unit_cost`,`selling_price`,`currency`,`warehouse_location`,`supplier`,`purchase_order_ref`,`purchased_at`,`notes`,`created_by`,`created_at`,`updated_at`) values (1,'ORD-2026-00001',1000,500,'gps_tracker','GPS Tracker','2026','new','partial',16.22,18.02,'USD',NULL,'Onine','Online purchase','2026-05-29','i have purchased this device online',2,'2026-05-29 15:16:10','2026-05-29 15:20:22');

/*Table structure for table `device_stock_sale_items` */

DROP TABLE IF EXISTS `device_stock_sale_items`;

CREATE TABLE `device_stock_sale_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `sale_id` bigint unsigned NOT NULL,
  `stock_order_id` bigint unsigned NOT NULL,
  `quantity` int unsigned NOT NULL DEFAULT '1',
  `unit_price` decimal(12,2) NOT NULL DEFAULT '0.00',
  `unit_cost` decimal(12,2) NOT NULL DEFAULT '0.00',
  `line_total` decimal(12,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `device_stock_sale_items_stock_order_id_sale_id_index` (`stock_order_id`,`sale_id`),
  KEY `device_stock_sale_items_sale_id_index` (`sale_id`),
  KEY `device_stock_sale_items_stock_order_id_index` (`stock_order_id`),
  CONSTRAINT `device_stock_sale_items_sale_id_foreign` FOREIGN KEY (`sale_id`) REFERENCES `device_stock_sales` (`id`) ON DELETE CASCADE,
  CONSTRAINT `device_stock_sale_items_stock_order_id_foreign` FOREIGN KEY (`stock_order_id`) REFERENCES `device_stock_orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `device_stock_sale_items` */

insert  into `device_stock_sale_items`(`id`,`sale_id`,`stock_order_id`,`quantity`,`unit_price`,`unit_cost`,`line_total`,`created_at`,`updated_at`) values (1,1,1,500,18.02,16.22,9010.00,'2026-05-29 15:20:22','2026-05-29 15:20:22');

/*Table structure for table `device_stock_sales` */

DROP TABLE IF EXISTS `device_stock_sales`;

CREATE TABLE `device_stock_sales` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `invoice_no` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `client_id` bigint unsigned NOT NULL,
  `currency` varchar(3) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'USD',
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'issued',
  `issued_at` date DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `device_stock_sales_invoice_no_unique` (`invoice_no`),
  KEY `device_stock_sales_client_id_index` (`client_id`),
  KEY `device_stock_sales_created_by_index` (`created_by`),
  CONSTRAINT `device_stock_sales_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `device_stock_sales` */

insert  into `device_stock_sales`(`id`,`invoice_no`,`client_id`,`currency`,`status`,`issued_at`,`notes`,`created_by`,`created_at`,`updated_at`) values (1,'INV-2026-00001',2,'USD','issued','2026-05-29','i am selling 500 devices to Falcon Eye',2,'2026-05-29 15:20:22','2026-05-29 15:20:22');

/*Table structure for table `failed_jobs` */

DROP TABLE IF EXISTS `failed_jobs`;

CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `failed_jobs` */

/*Table structure for table `inventory_fifo_layers` */

DROP TABLE IF EXISTS `inventory_fifo_layers`;

CREATE TABLE `inventory_fifo_layers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `product_id` bigint unsigned NOT NULL,
  `scope` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `scope_id` bigint unsigned DEFAULT NULL,
  `received_at` datetime NOT NULL,
  `unit_cost` decimal(12,2) NOT NULL DEFAULT '0.00',
  `currency` varchar(3) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'USD',
  `remaining_qty` int unsigned NOT NULL DEFAULT '0',
  `source_purchase_order_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `inventory_fifo_layers_scope_scope_id_received_at_index` (`scope`,`scope_id`,`received_at`),
  KEY `inventory_fifo_layers_product_id_index` (`product_id`),
  KEY `inventory_fifo_layers_scope_id_index` (`scope_id`),
  KEY `inventory_fifo_layers_received_at_index` (`received_at`),
  KEY `inventory_fifo_layers_source_purchase_order_id_index` (`source_purchase_order_id`),
  CONSTRAINT `inventory_fifo_layers_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `inventory_products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `inventory_fifo_layers` */

insert  into `inventory_fifo_layers`(`id`,`product_id`,`scope`,`scope_id`,`received_at`,`unit_cost`,`currency`,`remaining_qty`,`source_purchase_order_id`,`created_at`,`updated_at`) values (1,1,'warehouse',NULL,'2026-05-29 15:16:10',16.22,'USD',500,1,'2026-05-29 15:16:10','2026-05-29 15:20:22'),(2,1,'client',2,'2026-05-29 15:16:10',16.22,'USD',493,1,'2026-05-29 15:20:22','2026-06-05 02:40:35'),(3,1,'client',2,'2026-05-29 17:02:46',16.22,'USD',1,NULL,'2026-05-29 17:02:46','2026-05-29 17:02:46');

/*Table structure for table `inventory_movements` */

DROP TABLE IF EXISTS `inventory_movements`;

CREATE TABLE `inventory_movements` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `product_id` bigint unsigned NOT NULL,
  `scope` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `scope_id` bigint unsigned DEFAULT NULL,
  `type` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` int NOT NULL,
  `source_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `source_id` bigint unsigned DEFAULT NULL,
  `occurred_at` datetime NOT NULL,
  `created_by` bigint unsigned DEFAULT NULL,
  `meta` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `inventory_movements_scope_scope_id_occurred_at_index` (`scope`,`scope_id`,`occurred_at`),
  KEY `inventory_movements_type_occurred_at_index` (`type`,`occurred_at`),
  KEY `inventory_movements_product_id_index` (`product_id`),
  KEY `inventory_movements_scope_id_index` (`scope_id`),
  KEY `inventory_movements_occurred_at_index` (`occurred_at`),
  KEY `inventory_movements_created_by_index` (`created_by`),
  CONSTRAINT `inventory_movements_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `inventory_products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `inventory_movements` */

insert  into `inventory_movements`(`id`,`product_id`,`scope`,`scope_id`,`type`,`quantity`,`source_type`,`source_id`,`occurred_at`,`created_by`,`meta`,`created_at`,`updated_at`) values (1,1,'warehouse',NULL,'purchase',1000,'device_stock_orders',1,'2026-05-29 15:16:10',2,'{\"currency\": \"USD\", \"unit_cost\": 16.22, \"order_code\": \"ORD-2026-00001\"}','2026-05-29 15:16:10','2026-05-29 15:16:10'),(2,1,'warehouse',NULL,'sale_transfer',-500,'device_stock_sales',1,'2026-05-29 00:00:00',2,'{\"sale_item_id\": 1}','2026-05-29 15:20:22','2026-05-29 15:20:22'),(3,1,'client',2,'sale_transfer',500,'device_stock_sales',1,'2026-05-29 00:00:00',2,'{\"sale_item_id\": 1}','2026-05-29 15:20:22','2026-05-29 15:20:22'),(4,1,'client',2,'install',-1,'App\\Models\\Device',5,'2026-05-29 16:16:27',2,'{\"device_id\": 5}','2026-05-29 16:16:27','2026-05-29 16:16:27'),(5,1,'client',2,'install',-1,'App\\Models\\Device',5,'2026-05-29 16:29:37',2,'{\"device_id\": 5}','2026-05-29 16:29:37','2026-05-29 16:29:37'),(6,1,'client',2,'return',1,'App\\Models\\Device',5,'2026-05-29 17:02:46',2,'{\"reason\": \"subscription_cancelled\", \"device_id\": 5}','2026-05-29 17:02:46','2026-05-29 17:02:46'),(7,1,'client',2,'install',-1,'App\\Models\\Device',5,'2026-05-29 17:03:20',2,'{\"device_id\": 5}','2026-05-29 17:03:20','2026-05-29 17:03:20'),(8,1,'client',2,'install',-1,'App\\Models\\Device',6,'2026-05-30 01:52:00',2,'{\"device_id\": 6}','2026-05-30 01:52:00','2026-05-30 01:52:00'),(9,1,'client',2,'install',-1,'App\\Models\\Device',6,'2026-05-30 01:53:09',2,'{\"device_id\": 6}','2026-05-30 01:53:09','2026-05-30 01:53:09'),(10,1,'client',2,'install',-1,'App\\Models\\Device',7,'2026-06-05 02:40:12',2,'{\"device_id\": 7}','2026-06-05 02:40:12','2026-06-05 02:40:12'),(11,1,'client',2,'install',-1,'App\\Models\\Device',7,'2026-06-05 02:40:35',2,'{\"device_id\": 7}','2026-06-05 02:40:35','2026-06-05 02:40:35');

/*Table structure for table `inventory_products` */

DROP TABLE IF EXISTS `inventory_products`;

CREATE TABLE `inventory_products` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `device_type` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `brand` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `model` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sku` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `inventory_products_device_type_brand_model_unique` (`device_type`,`brand`,`model`),
  KEY `inventory_products_device_type_index` (`device_type`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `inventory_products` */

insert  into `inventory_products`(`id`,`device_type`,`brand`,`model`,`sku`,`created_at`,`updated_at`) values (1,'gps_tracker','GPS Tracker','2026',NULL,'2026-05-29 15:16:10','2026-05-29 15:16:10');

/*Table structure for table `job_batches` */

DROP TABLE IF EXISTS `job_batches`;

CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `job_batches` */

/*Table structure for table `jobs` */

DROP TABLE IF EXISTS `jobs`;

CREATE TABLE `jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint unsigned NOT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `jobs` */

/*Table structure for table `migrations` */

DROP TABLE IF EXISTS `migrations`;

CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `migrations` */

insert  into `migrations`(`id`,`migration`,`batch`) values (1,'0001_01_01_000000_create_users_table',1),(2,'0001_01_01_000001_create_cache_table',1),(3,'0001_01_01_000002_create_jobs_table',1),(4,'2025_01_01_000004_create_subscriptions_table',1),(5,'2025_12_09_124353_create_personal_access_tokens_table',1),(6,'2025_12_14_094234_create_contact_messages_table',1),(7,'2025_12_15_103337_create_activity_log_table',1),(8,'2025_12_15_103338_add_event_column_to_activity_log_table',1),(9,'2025_12_15_103339_add_batch_uuid_column_to_activity_log_table',1),(10,'2026_05_17_100000_add_device_id_to_subscriptions_table',1),(11,'2026_05_17_140000_create_subscription_histories_table',1),(12,'2026_05_24_000001_seed_default_tc_admin_user',1),(13,'2026_05_24_120000_create_multi_tenant_rbac_tables',2),(14,'2026_05_24_120001_migrate_legacy_admin_roles',2),(15,'2026_05_26_100000_add_can_track_maps_to_clients_table',2),(16,'2026_05_26_110000_grant_maps_view_to_existing_panel_users',2),(17,'2026_05_26_120000_migrate_device_types_to_gps_hardware',2),(18,'2026_05_26_140000_create_device_stock_units_table',2),(19,'2026_05_26_150000_add_batch_ref_to_device_stock_units_table',2),(20,'2026_05_26_160000_restructure_device_stock_as_orders',2),(21,'2026_05_26_170000_create_device_stock_sales_tables',2),(22,'2026_05_26_180000_migrate_activity_log_device_stock_subject_types',2),(23,'2026_05_27_090000_create_central_inventory_tables',2),(24,'2026_05_27_091000_backfill_central_inventory_from_existing_records',2),(25,'2026_05_27_120000_create_saas_billing_tables',2),(26,'2026_05_27_120001_seed_default_subscription_plans',2),(27,'2026_05_27_130000_add_billing_cycle_to_subscription_plans',2),(28,'2026_05_27_140000_remove_six_month_subscription_plans',2),(29,'2026_05_27_150000_allow_multiple_subscriptions_per_device',3),(30,'2026_05_27_200000_create_vehicle_event_reads_table',4),(31,'2026_05_28_120000_create_user_push_tokens_table',5),(32,'2026_05_28_140000_create_push_notification_logs_table',5),(33,'2026_05_29_100000_add_subscription_type_to_subscriptions_table',6);

/*Table structure for table `password_reset_tokens` */

DROP TABLE IF EXISTS `password_reset_tokens`;

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `password_reset_tokens` */

insert  into `password_reset_tokens`(`email`,`token`,`created_at`) values ('zhg786@gmail.com','$2y$12$I.SUdFqTukf1FEVyKasZJ.gBWKMYGT5jxhnaxg.Z1Qdb5VvriIpbO','2026-05-28 20:22:03');

/*Table structure for table `personal_access_tokens` */

DROP TABLE IF EXISTS `personal_access_tokens`;

CREATE TABLE `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  KEY `personal_access_tokens_expires_at_index` (`expires_at`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `personal_access_tokens` */

insert  into `personal_access_tokens`(`id`,`tokenable_type`,`tokenable_id`,`name`,`token`,`abilities`,`last_used_at`,`expires_at`,`created_at`,`updated_at`) values (1,'App\\Models\\User',3,'flutter-mobile','bd3352e5973d8c7e7abe07b427ad8ab2be3eac79117e9a3a6dc9f0bae7d51b31','[\"*\"]','2026-05-29 03:53:53',NULL,'2026-05-29 03:46:46','2026-05-29 03:53:53'),(2,'App\\Models\\User',3,'flutter-mobile','b1336237dc8b666f2c61b390658ba488f7db4a686f954bc5f9dcd5590d794472','[\"*\"]','2026-05-29 05:29:32',NULL,'2026-05-29 04:38:31','2026-05-29 05:29:32'),(3,'App\\Models\\User',3,'flutter-mobile','d3845d34a854c20a89e59356bb4371fc295f377d3343f5a1e53f5d09ff851bde','[\"*\"]','2026-05-29 05:32:58',NULL,'2026-05-29 04:43:04','2026-05-29 05:32:58'),(4,'App\\Models\\User',3,'flutter-mobile','7e0a21d1f5ef87f2ee3a60a57a70f6db38e6bbdc55d1752985f0dadc2775a45e','[\"*\"]','2026-05-29 05:43:31',NULL,'2026-05-29 05:39:05','2026-05-29 05:43:31'),(6,'App\\Models\\User',6,'flutter-mobile','f1289c6dbdb893b39093eb38e9da5098b79b9c108e3dca0f6da4e11bc4b4b21a','[\"*\"]','2026-05-29 18:00:51',NULL,'2026-05-29 17:45:37','2026-05-29 18:00:51'),(7,'App\\Models\\User',6,'flutter-mobile','a12a1e95df923a0fe0cdb023ac4a3dcf9ca5350cb89e66e07b4a2236be63a3cc','[\"*\"]','2026-05-30 23:45:41',NULL,'2026-05-29 18:26:07','2026-05-30 23:45:41'),(8,'App\\Models\\User',6,'flutter-mobile','b2dc6e99ec932bcd53b197c0b83d2b4484009152c4db7ca2df166300c67af3a8','[\"*\"]','2026-05-29 22:54:12',NULL,'2026-05-29 22:12:09','2026-05-29 22:54:12'),(9,'App\\Models\\User',6,'flutter-mobile','63cf8743d54b4c810ca7538b6cef6d55ae45eafce00370d594eeb4af2f6cb892','[\"*\"]','2026-05-30 02:14:23',NULL,'2026-05-29 23:55:20','2026-05-30 02:14:23'),(10,'App\\Models\\User',7,'flutter-mobile','e5aef74bc73711eb09dacc49a1cb2f66c168d8e72189e758fb17a9e96e5f777e','[\"*\"]','2026-05-30 16:16:42',NULL,'2026-05-30 02:30:46','2026-05-30 16:16:42'),(11,'App\\Models\\User',6,'flutter-mobile','565d6e053829b991cf554a4b7fed0df119d51494a6ce344c81c993f1618f9654','[\"*\"]','2026-05-30 20:48:42',NULL,'2026-05-30 16:16:52','2026-05-30 20:48:42'),(12,'App\\Models\\User',7,'flutter-mobile','9773af3707c76626aabfab5b89413932c65343dfdacd63675df724f6127c1754','[\"*\"]','2026-05-30 20:50:04',NULL,'2026-05-30 20:49:03','2026-05-30 20:50:04'),(13,'App\\Models\\User',6,'flutter-mobile','3e2c99da3d5cbdaa1275d152fd4708f1d2b61c698d9aa8f83b65c698594940e3','[\"*\"]','2026-05-31 03:24:10',NULL,'2026-05-30 20:50:20','2026-05-31 03:24:10'),(14,'App\\Models\\User',6,'flutter-mobile','4f0c21ae5d6cd1388c8765f3b439d873f80de33e77d86251b529b0d7afad8932','[\"*\"]','2026-05-31 17:09:00',NULL,'2026-05-30 23:45:59','2026-05-31 17:09:00'),(15,'App\\Models\\User',6,'mobile-app','9cbc1248a8a0f89f87fefbf1c1f410062dd701e29ed960002f7faf70598fe43f','[\"*\"]',NULL,NULL,'2026-05-31 02:19:04','2026-05-31 02:19:04'),(16,'App\\Models\\User',6,'flutter-mobile','d2bef9816a4463b67169317cc55d8786a37cf856691d5803e9814fe119a366c6','[\"*\"]','2026-06-01 12:15:27',NULL,'2026-05-31 17:37:50','2026-06-01 12:15:27'),(18,'App\\Models\\User',6,'flutter-mobile','cc42ec18aa6548e0d5cebb8176a0a11d1f445c0be535c4a7446140f9374013e2','[\"*\"]','2026-06-01 13:12:30',NULL,'2026-06-01 12:20:21','2026-06-01 13:12:30'),(19,'App\\Models\\User',6,'cli-test','7e90308a13bb4f2ff7f83114ed6f19d3d66fad1718941a2bebd50d44db74422f','[\"*\"]',NULL,NULL,'2026-06-01 12:50:09','2026-06-01 12:50:09'),(20,'App\\Models\\User',6,'flutter-mobile','c24addb9294def1b884d0968547be74d47a7043324e3dcdbfc2c0d085f4d8d80','[\"*\"]','2026-06-01 13:25:36',NULL,'2026-06-01 13:13:24','2026-06-01 13:25:36'),(21,'App\\Models\\User',6,'flutter-mobile','0302d260809dd0a06df3b6837a8f074c98071c97b826eb36bde86e00d8e865d6','[\"*\"]','2026-06-01 14:02:26',NULL,'2026-06-01 13:33:34','2026-06-01 14:02:26'),(23,'App\\Models\\User',6,'flutter-mobile','c6b6d8ee019745b821ff2d45fd94ecd54503fb3cf0e981038b9030272f16a667','[\"*\"]','2026-06-02 00:29:32',NULL,'2026-06-02 00:28:24','2026-06-02 00:29:32'),(24,'App\\Models\\User',6,'flutter-mobile','b1657400538bca9bc20f92621c6ecfc2ffba96e8f3a6a41620b3da75d97536a6','[\"*\"]','2026-06-02 01:14:51',NULL,'2026-06-02 01:07:58','2026-06-02 01:14:51'),(25,'App\\Models\\User',6,'flutter-mobile','7c0871b3e02381c8595bb11ec250dc8421b83ff16b8204efe97a118faaeb033c','[\"*\"]','2026-06-03 01:26:12',NULL,'2026-06-02 13:30:00','2026-06-03 01:26:12'),(26,'App\\Models\\User',6,'flutter-mobile','26317f52d2ef918a6a3b37334f13367de893832fda66be579dda726c48457be3','[\"*\"]','2026-06-05 01:02:54',NULL,'2026-06-03 12:09:41','2026-06-05 01:02:54'),(28,'App\\Models\\User',6,'flutter-mobile','a1e415cde7a2d0c4bc54352531ec2206e566ec42f1c43b0f5fcb1eb8a1decb58','[\"*\"]','2026-06-03 22:41:30',NULL,'2026-06-03 22:40:29','2026-06-03 22:41:30'),(31,'App\\Models\\User',9,'flutter-mobile','06b0d1ea5dd73835a434959a32062544a344c8c708f996b7eaf47e5760b60e42','[\"*\"]','2026-06-05 15:29:52',NULL,'2026-06-05 03:07:40','2026-06-05 15:29:52');

/*Table structure for table `push_notification_logs` */

DROP TABLE IF EXISTS `push_notification_logs`;

CREATE TABLE `push_notification_logs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `fcm_token_hash` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `push_type` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `body` text COLLATE utf8mb4_unicode_ci,
  `status` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL,
  `http_status` smallint unsigned DEFAULT NULL,
  `error_message` text COLLATE utf8mb4_unicode_ci,
  `response` json DEFAULT NULL,
  `data` json DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `push_notification_logs_user_id_created_at_index` (`user_id`,`created_at`),
  KEY `push_notification_logs_status_created_at_index` (`status`,`created_at`),
  KEY `push_notification_logs_push_type_index` (`push_type`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `push_notification_logs` */

insert  into `push_notification_logs`(`id`,`user_id`,`fcm_token_hash`,`push_type`,`title`,`body`,`status`,`http_status`,`error_message`,`response`,`data`,`created_at`) values (1,3,'698fbbde3101764fb72c0b7478ddd80deccbe5d02c0d7e15eb08c3c3a050fc20','geofence_enter','Geofence enter','Zakir Device entered geofence \"New Geofence\". · 25 May 2026, 2:00 PM','failed',404,'{\n  \"error\": {\n    \"code\": 404,\n    \"message\": \"Requested entity was not found.\",\n    \"status\": \"NOT_FOUND\",\n    \"details\": [\n      {\n        \"@type\": \"type.googleapis.com/google.firebase.fcm.v1.FcmError\",\n        \"errorCode\": \"UNREGISTERED\"\n      }\n    ]\n  }\n}\n','{\"error\": {\"code\": 404, \"status\": \"NOT_FOUND\", \"details\": [{\"@type\": \"type.googleapis.com/google.firebase.fcm.v1.FcmError\", \"errorCode\": \"UNREGISTERED\"}], \"message\": \"Requested entity was not found.\"}}','{\"time\": \"2026-05-25T14:00:49+05:00\", \"type\": \"geofence_enter\", \"screen\": \"map\", \"event_id\": \"50\", \"device_id\": \"4\", \"event_type\": \"geofence_enter\", \"device_name\": \"Zakir Device\", \"geofence_id\": \"2\", \"time_display\": \"25 May 2026, 2:00 PM\"}','2026-05-29 04:38:33'),(2,3,'08e162e4c314501c50ff06fd716134479a26e5fa4b39b6872824134bef731e62','geofence_enter','Geofence enter','Zakir Device entered geofence \"New Geofence\". · 25 May 2026, 2:00 PM','sent',200,NULL,'{\"name\": \"projects/falconeyegps-37856/messages/0:1780011514051571%b213ea0cb213ea0c\"}','{\"time\": \"2026-05-25T14:00:49+05:00\", \"type\": \"geofence_enter\", \"screen\": \"map\", \"event_id\": \"50\", \"device_id\": \"4\", \"event_type\": \"geofence_enter\", \"device_name\": \"Zakir Device\", \"geofence_id\": \"2\", \"time_display\": \"25 May 2026, 2:00 PM\"}','2026-05-29 04:38:34'),(3,3,'08e162e4c314501c50ff06fd716134479a26e5fa4b39b6872824134bef731e62','geofence_enter','Geofence enter','V27-Zahid entered geofence \"Home\". · 24 May 2026, 6:17 AM','sent',200,NULL,'{\"name\": \"projects/falconeyegps-37856/messages/0:1780011514514691%b213ea0cb213ea0c\"}','{\"time\": \"2026-05-24T06:17:23+05:00\", \"type\": \"geofence_enter\", \"screen\": \"map\", \"event_id\": \"51\", \"device_id\": \"3\", \"event_type\": \"geofence_enter\", \"device_name\": \"V27-Zahid\", \"geofence_id\": \"1\", \"time_display\": \"24 May 2026, 6:17 AM\"}','2026-05-29 04:38:34'),(4,3,'08e162e4c314501c50ff06fd716134479a26e5fa4b39b6872824134bef731e62','geofence_enter','Geofence enter','Zakir Device entered geofence \"New Geofence\". · 25 May 2026, 2:00 PM','sent',200,NULL,'{\"name\": \"projects/falconeyegps-37856/messages/0:1780014776039782%b213ea0cb213ea0c\"}','{\"time\": \"2026-05-25T14:00:49+05:00\", \"type\": \"geofence_enter\", \"screen\": \"map\", \"event_id\": \"52\", \"device_id\": \"4\", \"event_type\": \"geofence_enter\", \"device_name\": \"Zakir Device\", \"geofence_id\": \"2\", \"time_display\": \"25 May 2026, 2:00 PM\"}','2026-05-29 05:32:56'),(5,3,'071e0fe50420076e8e2a51a4ad4b071d59d45d8654add3304495abb7fb9962e4','geofence_enter','Geofence enter','Zakir Device entered geofence \"New Geofence\". · 25 May 2026, 2:00 PM','sent',200,NULL,'{\"name\": \"projects/falconeyegps-37856/messages/0:1780014776138933%b213ea0cb213ea0c\"}','{\"time\": \"2026-05-25T14:00:49+05:00\", \"type\": \"geofence_enter\", \"screen\": \"map\", \"event_id\": \"52\", \"device_id\": \"4\", \"event_type\": \"geofence_enter\", \"device_name\": \"Zakir Device\", \"geofence_id\": \"2\", \"time_display\": \"25 May 2026, 2:00 PM\"}','2026-05-29 05:32:56'),(6,3,'08e162e4c314501c50ff06fd716134479a26e5fa4b39b6872824134bef731e62','geofence_enter','Geofence enter','V27-Zahid entered geofence \"Home\". · 24 May 2026, 6:17 AM','sent',200,NULL,'{\"name\": \"projects/falconeyegps-37856/messages/0:1780014776778242%b213ea0cb213ea0c\"}','{\"time\": \"2026-05-24T06:17:23+05:00\", \"type\": \"geofence_enter\", \"screen\": \"map\", \"event_id\": \"53\", \"device_id\": \"3\", \"event_type\": \"geofence_enter\", \"device_name\": \"V27-Zahid\", \"geofence_id\": \"1\", \"time_display\": \"24 May 2026, 6:17 AM\"}','2026-05-29 05:32:56'),(7,3,'071e0fe50420076e8e2a51a4ad4b071d59d45d8654add3304495abb7fb9962e4','geofence_enter','Geofence enter','V27-Zahid entered geofence \"Home\". · 24 May 2026, 6:17 AM','sent',200,NULL,'{\"name\": \"projects/falconeyegps-37856/messages/0:1780014776908294%b213ea0cb213ea0c\"}','{\"time\": \"2026-05-24T06:17:23+05:00\", \"type\": \"geofence_enter\", \"screen\": \"map\", \"event_id\": \"53\", \"device_id\": \"3\", \"event_type\": \"geofence_enter\", \"device_name\": \"V27-Zahid\", \"geofence_id\": \"1\", \"time_display\": \"24 May 2026, 6:17 AM\"}','2026-05-29 05:32:56'),(8,3,'08e162e4c314501c50ff06fd716134479a26e5fa4b39b6872824134bef731e62','geofence_enter','Geofence enter','Zakir Device entered geofence \"New Geofence\". · 25 May 2026, 2:00 PM','sent',200,NULL,'{\"name\": \"projects/falconeyegps-37856/messages/0:1780015116480055%b213ea0cb213ea0c\"}','{\"time\": \"2026-05-25T14:00:49+05:00\", \"type\": \"geofence_enter\", \"screen\": \"map\", \"event_id\": \"54\", \"device_id\": \"4\", \"event_type\": \"geofence_enter\", \"device_name\": \"Zakir Device\", \"geofence_id\": \"2\", \"time_display\": \"25 May 2026, 2:00 PM\"}','2026-05-29 05:38:36'),(9,3,'071e0fe50420076e8e2a51a4ad4b071d59d45d8654add3304495abb7fb9962e4','geofence_enter','Geofence enter','Zakir Device entered geofence \"New Geofence\". · 25 May 2026, 2:00 PM','failed',404,'{\n  \"error\": {\n    \"code\": 404,\n    \"message\": \"Requested entity was not found.\",\n    \"status\": \"NOT_FOUND\",\n    \"details\": [\n      {\n        \"@type\": \"type.googleapis.com/google.firebase.fcm.v1.FcmError\",\n        \"errorCode\": \"UNREGISTERED\"\n      }\n    ]\n  }\n}\n','{\"error\": {\"code\": 404, \"status\": \"NOT_FOUND\", \"details\": [{\"@type\": \"type.googleapis.com/google.firebase.fcm.v1.FcmError\", \"errorCode\": \"UNREGISTERED\"}], \"message\": \"Requested entity was not found.\"}}','{\"time\": \"2026-05-25T14:00:49+05:00\", \"type\": \"geofence_enter\", \"screen\": \"map\", \"event_id\": \"54\", \"device_id\": \"4\", \"event_type\": \"geofence_enter\", \"device_name\": \"Zakir Device\", \"geofence_id\": \"2\", \"time_display\": \"25 May 2026, 2:00 PM\"}','2026-05-29 05:38:36'),(10,3,'08e162e4c314501c50ff06fd716134479a26e5fa4b39b6872824134bef731e62','geofence_enter','Geofence enter','V27-Zahid entered geofence \"Home\". · 24 May 2026, 6:17 AM','sent',200,NULL,'{\"name\": \"projects/falconeyegps-37856/messages/0:1780015148263330%b213ea0cb213ea0c\"}','{\"time\": \"2026-05-24T06:17:23+05:00\", \"type\": \"geofence_enter\", \"screen\": \"map\", \"event_id\": \"55\", \"device_id\": \"3\", \"event_type\": \"geofence_enter\", \"device_name\": \"V27-Zahid\", \"geofence_id\": \"1\", \"time_display\": \"24 May 2026, 6:17 AM\"}','2026-05-29 05:39:08'),(11,3,'08b7991982df4690708d68243d44a2571074703b57dc2877c6220ca7bbdf0366','geofence_enter','Geofence enter','V27-Zahid entered geofence \"Home\". · 24 May 2026, 6:17 AM','sent',200,NULL,'{\"name\": \"projects/falconeyegps-37856/messages/0:1780015148360384%b213ea0cb213ea0c\"}','{\"time\": \"2026-05-24T06:17:23+05:00\", \"type\": \"geofence_enter\", \"screen\": \"map\", \"event_id\": \"55\", \"device_id\": \"3\", \"event_type\": \"geofence_enter\", \"device_name\": \"V27-Zahid\", \"geofence_id\": \"1\", \"time_display\": \"24 May 2026, 6:17 AM\"}','2026-05-29 05:39:08'),(12,6,'5f100927af8fd30a8144be5117d47c6b14cfe931f7cdbca4df38b882e72332ff','vehicle_moving','Vehicle running','Traccar is moving at 35 km/h. · 29 May 2026, 5:06 PM','sent',200,NULL,'{\"name\": \"projects/falconeyegps-37856/messages/0:1780057360458053%b213ea0cb213ea0c\"}','{\"time\": \"2026-05-29T17:06:00+05:00\", \"type\": \"vehicle_moving\", \"screen\": \"device\", \"event_id\": \"56\", \"device_id\": \"5\", \"event_type\": \"running\", \"device_name\": \"Traccar\", \"geofence_id\": \"\", \"time_display\": \"29 May 2026, 5:06 PM\"}','2026-05-29 17:22:40'),(13,6,'5f100927af8fd30a8144be5117d47c6b14cfe931f7cdbca4df38b882e72332ff','device_online','Device online','Traccar is back online and reporting GPS. · 29 May 2026, 5:22 PM','sent',200,NULL,'{\"name\": \"projects/falconeyegps-37856/messages/0:1780057360583903%b213ea0cb213ea0c\"}','{\"time\": \"2026-05-29T17:22:40+05:00\", \"type\": \"device_online\", \"screen\": \"device\", \"device_id\": \"5\", \"device_name\": \"Traccar\", \"time_display\": \"29 May 2026, 5:22 PM\"}','2026-05-29 17:22:40'),(14,6,'5f100927af8fd30a8144be5117d47c6b14cfe931f7cdbca4df38b882e72332ff','vehicle_moving','Slow speed','Traccar is moving slowly at 20 km/h. · 29 May 2026, 5:06 PM','sent',200,NULL,'{\"name\": \"projects/falconeyegps-37856/messages/0:1780057637935877%b213ea0cb213ea0c\"}','{\"time\": \"2026-05-29T17:06:00+05:00\", \"type\": \"vehicle_moving\", \"screen\": \"device\", \"event_id\": \"57\", \"device_id\": \"5\", \"event_type\": \"slow_speed\", \"device_name\": \"Traccar\", \"geofence_id\": \"\", \"time_display\": \"29 May 2026, 5:06 PM\"}','2026-05-29 17:27:17'),(15,6,'5f100927af8fd30a8144be5117d47c6b14cfe931f7cdbca4df38b882e72332ff','vehicle_moving','Vehicle running','Traccar is moving at 40 km/h. · 29 May 2026, 5:06 PM','sent',200,NULL,'{\"name\": \"projects/falconeyegps-37856/messages/0:1780057951584070%b213ea0cb213ea0c\"}','{\"time\": \"2026-05-29T17:06:00+05:00\", \"type\": \"vehicle_moving\", \"screen\": \"device\", \"event_id\": \"58\", \"device_id\": \"5\", \"event_type\": \"running\", \"device_name\": \"Traccar\", \"geofence_id\": \"\", \"time_display\": \"29 May 2026, 5:06 PM\"}','2026-05-29 17:32:31'),(16,6,'5f100927af8fd30a8144be5117d47c6b14cfe931f7cdbca4df38b882e72332ff','overspeed','Overspeed','Traccar exceeded 80 km/h limit (current 120 km/h). · 29 May 2026, 5:06 PM','sent',200,NULL,'{\"name\": \"projects/falconeyegps-37856/messages/0:1780058143105075%b213ea0cb213ea0c\"}','{\"time\": \"2026-05-29T17:06:00+05:00\", \"type\": \"overspeed\", \"screen\": \"device\", \"event_id\": \"59\", \"device_id\": \"5\", \"event_type\": \"overspeed\", \"device_name\": \"Traccar\", \"geofence_id\": \"\", \"time_display\": \"29 May 2026, 5:06 PM\"}','2026-05-29 17:35:43'),(17,6,'5f100927af8fd30a8144be5117d47c6b14cfe931f7cdbca4df38b882e72332ff','vehicle_moving','Vehicle running','Traccar is moving at 40 km/h. · 29 May 2026, 5:06 PM','failed',404,'{\n  \"error\": {\n    \"code\": 404,\n    \"message\": \"Requested entity was not found.\",\n    \"status\": \"NOT_FOUND\",\n    \"details\": [\n      {\n        \"@type\": \"type.googleapis.com/google.firebase.fcm.v1.FcmError\",\n        \"errorCode\": \"UNREGISTERED\"\n      }\n    ]\n  }\n}\n','{\"error\": {\"code\": 404, \"status\": \"NOT_FOUND\", \"details\": [{\"@type\": \"type.googleapis.com/google.firebase.fcm.v1.FcmError\", \"errorCode\": \"UNREGISTERED\"}], \"message\": \"Requested entity was not found.\"}}','{\"time\": \"2026-05-29T17:06:00+05:00\", \"type\": \"vehicle_moving\", \"screen\": \"device\", \"event_id\": \"60\", \"device_id\": \"5\", \"event_type\": \"running\", \"device_name\": \"Traccar\", \"geofence_id\": \"\", \"time_display\": \"29 May 2026, 5:06 PM\"}','2026-05-30 00:28:39'),(18,6,'9d23197f3cd37ade3501509cee20801fcc452f027faddbbcb9bb9e08dcb7db30','vehicle_moving','Vehicle running','Traccar is moving at 40 km/h. · 29 May 2026, 5:06 PM','sent',200,NULL,'{\"name\": \"projects/falconeyegps-37856/messages/0:1780082919258626%b213ea0cb213ea0c\"}','{\"time\": \"2026-05-29T17:06:00+05:00\", \"type\": \"vehicle_moving\", \"screen\": \"device\", \"event_id\": \"60\", \"device_id\": \"5\", \"event_type\": \"running\", \"device_name\": \"Traccar\", \"geofence_id\": \"\", \"time_display\": \"29 May 2026, 5:06 PM\"}','2026-05-30 00:28:39'),(19,6,'39eb3e73c1660667bad0544be6af6f26455a1213ec5a3bdfde230eabcb64baf0','vehicle_moving','Vehicle running','Traccar is moving at 40 km/h. · 29 May 2026, 5:06 PM','failed',404,'{\n  \"error\": {\n    \"code\": 404,\n    \"message\": \"Requested entity was not found.\",\n    \"status\": \"NOT_FOUND\",\n    \"details\": [\n      {\n        \"@type\": \"type.googleapis.com/google.firebase.fcm.v1.FcmError\",\n        \"errorCode\": \"UNREGISTERED\"\n      }\n    ]\n  }\n}\n','{\"error\": {\"code\": 404, \"status\": \"NOT_FOUND\", \"details\": [{\"@type\": \"type.googleapis.com/google.firebase.fcm.v1.FcmError\", \"errorCode\": \"UNREGISTERED\"}], \"message\": \"Requested entity was not found.\"}}','{\"time\": \"2026-05-29T17:06:00+05:00\", \"type\": \"vehicle_moving\", \"screen\": \"device\", \"event_id\": \"60\", \"device_id\": \"5\", \"event_type\": \"running\", \"device_name\": \"Traccar\", \"geofence_id\": \"\", \"time_display\": \"29 May 2026, 5:06 PM\"}','2026-05-30 00:28:39'),(20,6,'e5a2ba0ffd826f48528f165356b41256074f7d6664434aca202915bfb80e38ed','vehicle_moving','Vehicle running','Traccar is moving at 40 km/h. · 29 May 2026, 5:06 PM','sent',200,NULL,'{\"name\": \"projects/falconeyegps-37856/messages/0:1780082919579485%b213ea0cb213ea0c\"}','{\"time\": \"2026-05-29T17:06:00+05:00\", \"type\": \"vehicle_moving\", \"screen\": \"device\", \"event_id\": \"60\", \"device_id\": \"5\", \"event_type\": \"running\", \"device_name\": \"Traccar\", \"geofence_id\": \"\", \"time_display\": \"29 May 2026, 5:06 PM\"}','2026-05-30 00:28:39'),(21,6,'9d23197f3cd37ade3501509cee20801fcc452f027faddbbcb9bb9e08dcb7db30','device_online','Device online','Traccar is back online and reporting GPS. · 30 May 2026, 12:28 AM','sent',200,NULL,'{\"name\": \"projects/falconeyegps-37856/messages/0:1780082919714154%b213ea0cb213ea0c\"}','{\"time\": \"2026-05-30T00:28:39+05:00\", \"type\": \"device_online\", \"screen\": \"device\", \"device_id\": \"5\", \"device_name\": \"Traccar\", \"time_display\": \"30 May 2026, 12:28 AM\"}','2026-05-30 00:28:39'),(22,6,'e5a2ba0ffd826f48528f165356b41256074f7d6664434aca202915bfb80e38ed','device_online','Device online','Traccar is back online and reporting GPS. · 30 May 2026, 12:28 AM','sent',200,NULL,'{\"name\": \"projects/falconeyegps-37856/messages/0:1780082919834630%b213ea0cb213ea0c\"}','{\"time\": \"2026-05-30T00:28:39+05:00\", \"type\": \"device_online\", \"screen\": \"device\", \"device_id\": \"5\", \"device_name\": \"Traccar\", \"time_display\": \"30 May 2026, 12:28 AM\"}','2026-05-30 00:28:39'),(23,6,'9d23197f3cd37ade3501509cee20801fcc452f027faddbbcb9bb9e08dcb7db30','vehicle_parked','Vehicle stopped','Traccar has stopped (speed 0 km/h). · 29 May 2026, 5:06 PM','sent',200,NULL,'{\"name\": \"projects/falconeyegps-37856/messages/0:1780083499562686%b213ea0cb213ea0c\"}','{\"time\": \"2026-05-29T17:06:00+05:00\", \"type\": \"vehicle_parked\", \"screen\": \"device\", \"event_id\": \"61\", \"device_id\": \"5\", \"event_type\": \"stopped\", \"device_name\": \"Traccar\", \"geofence_id\": \"\", \"time_display\": \"29 May 2026, 5:06 PM\"}','2026-05-30 00:38:19'),(24,6,'e5a2ba0ffd826f48528f165356b41256074f7d6664434aca202915bfb80e38ed','vehicle_parked','Vehicle stopped','Traccar has stopped (speed 0 km/h). · 29 May 2026, 5:06 PM','sent',200,NULL,'{\"name\": \"projects/falconeyegps-37856/messages/0:1780083499679192%b213ea0cb213ea0c\"}','{\"time\": \"2026-05-29T17:06:00+05:00\", \"type\": \"vehicle_parked\", \"screen\": \"device\", \"event_id\": \"61\", \"device_id\": \"5\", \"event_type\": \"stopped\", \"device_name\": \"Traccar\", \"geofence_id\": \"\", \"time_display\": \"29 May 2026, 5:06 PM\"}','2026-05-30 00:38:19'),(25,6,'9d23197f3cd37ade3501509cee20801fcc452f027faddbbcb9bb9e08dcb7db30','vehicle_stopped','Vehicle stopped','Swift VXL has stopped (speed 0 km/h). · 29 May 2026, 5:06 PM','sent',200,NULL,'{\"name\": \"projects/falconeyegps-37856/messages/0:1780139723849203%b213ea0cb213ea0c\"}','{\"time\": \"2026-05-29T17:06:00+05:00\", \"type\": \"vehicle_stopped\", \"screen\": \"device\", \"event_id\": \"68\", \"device_id\": \"5\", \"event_type\": \"stopped\", \"device_name\": \"Swift VXL\", \"geofence_id\": \"\", \"time_display\": \"29 May 2026, 5:06 PM\"}','2026-05-30 16:15:23'),(26,6,'9d23197f3cd37ade3501509cee20801fcc452f027faddbbcb9bb9e08dcb7db30','device_online','Device online','Swift VXL is back online and reporting GPS. · 30 May 2026, 4:15 PM','sent',200,NULL,'{\"name\": \"projects/falconeyegps-37856/messages/0:1780139723980215%b213ea0cb213ea0c\"}','{\"time\": \"2026-05-30T16:15:23+05:00\", \"type\": \"device_online\", \"screen\": \"device\", \"device_id\": \"5\", \"device_name\": \"Swift VXL\", \"time_display\": \"30 May 2026, 4:15 PM\"}','2026-05-30 16:15:24'),(27,6,'9d23197f3cd37ade3501509cee20801fcc452f027faddbbcb9bb9e08dcb7db30','vehicle_started','Vehicle running','Swift VXL is moving at 40 km/h. · 29 May 2026, 5:06 PM','sent',200,NULL,'{\"name\": \"projects/falconeyegps-37856/messages/0:1780139950970714%b213ea0cb213ea0c\"}','{\"time\": \"2026-05-29T17:06:00+05:00\", \"type\": \"vehicle_started\", \"screen\": \"device\", \"event_id\": \"69\", \"device_id\": \"5\", \"event_type\": \"running\", \"device_name\": \"Swift VXL\", \"geofence_id\": \"\", \"time_display\": \"29 May 2026, 5:06 PM\"}','2026-05-30 16:19:10'),(28,6,'e5a2ba0ffd826f48528f165356b41256074f7d6664434aca202915bfb80e38ed','vehicle_started','Vehicle running','Swift VXL is moving at 40 km/h. · 29 May 2026, 5:06 PM','sent',200,NULL,'{\"name\": \"projects/falconeyegps-37856/messages/0:1780139951102010%b213ea0cb213ea0c\"}','{\"time\": \"2026-05-29T17:06:00+05:00\", \"type\": \"vehicle_started\", \"screen\": \"device\", \"event_id\": \"69\", \"device_id\": \"5\", \"event_type\": \"running\", \"device_name\": \"Swift VXL\", \"geofence_id\": \"\", \"time_display\": \"29 May 2026, 5:06 PM\"}','2026-05-30 16:19:11'),(29,6,'e5a2ba0ffd826f48528f165356b41256074f7d6664434aca202915bfb80e38ed','overspeed','Overspeed','Swift VXL exceeded 80 km/h limit (current 85 km/h). · 31 May 2026, 1:11 PM','sent',200,NULL,'{\"name\": \"projects/falconeyegps-37856/messages/0:1780215106017691%b213ea0cb213ea0c\"}','{\"time\": \"2026-05-31T13:11:45+05:00\", \"type\": \"overspeed\", \"screen\": \"device\", \"event_id\": \"72\", \"device_id\": \"5\", \"event_type\": \"overspeed\", \"device_name\": \"Swift VXL\", \"geofence_id\": \"\", \"time_display\": \"31 May 2026, 1:11 PM\"}','2026-05-31 13:11:46'),(30,6,'9d23197f3cd37ade3501509cee20801fcc452f027faddbbcb9bb9e08dcb7db30','overspeed','Overspeed','Swift VXL exceeded 80 km/h limit (current 85 km/h). · 31 May 2026, 1:11 PM','sent',200,NULL,'{\"name\": \"projects/falconeyegps-37856/messages/0:1780215106131975%b213ea0cb213ea0c\"}','{\"time\": \"2026-05-31T13:11:45+05:00\", \"type\": \"overspeed\", \"screen\": \"device\", \"event_id\": \"72\", \"device_id\": \"5\", \"event_type\": \"overspeed\", \"device_name\": \"Swift VXL\", \"geofence_id\": \"\", \"time_display\": \"31 May 2026, 1:11 PM\"}','2026-05-31 13:11:46');

/*Table structure for table `sessions` */

DROP TABLE IF EXISTS `sessions`;

CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `sessions` */

insert  into `sessions`(`id`,`user_id`,`ip_address`,`user_agent`,`payload`,`last_activity`) values ('4s1DNX32KhU2JNxuIvYrcrDy6eqpjIean5j3GayK',NULL,'153.202.187.13','','YTo0OntzOjY6Il90b2tlbiI7czo0MDoicGFVbXNmQnpTTWhvVHJvNmRsc2FDUlZad0tXWjZWOWxQYVpuVmFDSiI7czo2OiJsb2NhbGUiO3M6MjoiZW4iO3M6OToiX3ByZXZpb3VzIjthOjI6e3M6MzoidXJsIjtzOjIwOiJodHRwOi8vNTIuNTcuMTY2LjIwNSI7czo1OiJyb3V0ZSI7czo0OiJob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1780764540),('BbKlPOtUCc84dMKE2SlvAl7NvekMjtnGyJshMbtr',NULL,'8.216.89.32','Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0;','YTo0OntzOjY6Il90b2tlbiI7czo0MDoiaExGdmN2YlgyUVRSdDBzYXNxWVJYSjlXbjFYclJIb3J6UGlGbWo2ZCI7czo2OiJsb2NhbGUiO3M6MjoiZW4iO3M6OToiX3ByZXZpb3VzIjthOjI6e3M6MzoidXJsIjtzOjIxOiJodHRwczovLzUyLjU3LjE2Ni4yMDUiO3M6NToicm91dGUiO3M6NDoiaG9tZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=',1780760272),('bRvtWJzMF3UVPxJP2szXRdrRvIqmEPwgGo2ENCI8',NULL,'188.255.165.193','Go-http-client/1.1','YTo0OntzOjY6Il90b2tlbiI7czo0MDoiY1BhNVhYdXV2M1lIblMxU3dRSVNXWEVwMHhJMllLdWRvQ2NLb0tocCI7czo2OiJsb2NhbGUiO3M6MjoiZW4iO3M6OToiX3ByZXZpb3VzIjthOjI6e3M6MzoidXJsIjtzOjIwOiJodHRwOi8vNTIuNTcuMTY2LjIwNSI7czo1OiJyb3V0ZSI7czo0OiJob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1780763643),('CSxg235s1tL1F7kKb3TlcqfEloXaSVzf1cV1Mx2q',NULL,'170.106.73.216','Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1','YTo0OntzOjY6Il90b2tlbiI7czo0MDoia1JvT1F6WW5Zem9zWjdyczU3M240SElnbnhHbjEzblJ4ZTA0S0RHTSI7czo2OiJsb2NhbGUiO3M6MjoiZW4iO3M6OToiX3ByZXZpb3VzIjthOjI6e3M6MzoidXJsIjtzOjIzOiJodHRwOi8vZmFsY29uZXllZ3BzLmNvbSI7czo1OiJyb3V0ZSI7czo0OiJob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1780761772),('Dv3qAaYjVOdUyVYo3I7pA8bJSG4kx4VwVCcZRE6g',NULL,'47.254.69.213','curl/7.64.1','YTo0OntzOjY6Il90b2tlbiI7czo0MDoiWDIxc2pwTjlwTVpGYUp3VEhWU2hmMzlNTjRYRUt5WVZoeVk0ZmFaOCI7czo2OiJsb2NhbGUiO3M6MjoiZW4iO3M6OToiX3ByZXZpb3VzIjthOjI6e3M6MzoidXJsIjtzOjIxOiJodHRwczovLzUyLjU3LjE2Ni4yMDUiO3M6NToicm91dGUiO3M6NDoiaG9tZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=',1780768830),('eKVTDKe2ou790kJQMHlaCUfIv7QJMH3yxfwSDh73',NULL,'188.255.165.193','Go-http-client/1.1','YTo0OntzOjY6Il90b2tlbiI7czo0MDoiMGwybFVSclEwUDFqd2UxTEFJM1dDVjFtM0FPTFN0S0lObUtMNEpWWiI7czo2OiJsb2NhbGUiO3M6MjoiZW4iO3M6OToiX3ByZXZpb3VzIjthOjI6e3M6MzoidXJsIjtzOjIxOiJodHRwczovLzUyLjU3LjE2Ni4yMDUiO3M6NToicm91dGUiO3M6NDoiaG9tZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=',1780763643),('hsnwUNIRnAzfSGKOdeyYwitN8DMzqjk3orJ2fVTs',NULL,'18.217.177.214','visionheight.com/scan Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36','YTo0OntzOjY6Il90b2tlbiI7czo0MDoiQUY3SlNjYlVlVEU1N0xpUzZlQmhYcVpkUlFHUWNtMkYzNThkaFB6SyI7czo2OiJsb2NhbGUiO3M6MjoiZW4iO3M6OToiX3ByZXZpb3VzIjthOjI6e3M6MzoidXJsIjtzOjIxOiJodHRwczovLzUyLjU3LjE2Ni4yMDUiO3M6NToicm91dGUiO3M6NDoiaG9tZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=',1780760482),('ITSIQZUM9A44pyHaLTlNqZwOMSg09CVlyrL4Oilx',NULL,'8.216.85.238','Mozilla/5.0 (Windows NT 6.2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/28.0.1500.95 Safari/537.36','YTo0OntzOjY6Il90b2tlbiI7czo0MDoiUDNEeVhWaFNJTlRhT0hOaDAxa1k3eEt4Y05WUFJGbndIdVo3TUhXbiI7czo2OiJsb2NhbGUiO3M6MjoiZW4iO3M6OToiX3ByZXZpb3VzIjthOjI6e3M6MzoidXJsIjtzOjIwOiJodHRwOi8vNTIuNTcuMTY2LjIwNSI7czo1OiJyb3V0ZSI7czo0OiJob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1780760305),('izoEKJkpKKILCvAoQlj5JCT5D4aBwZUZYibZye5c',NULL,'109.105.194.6','LRVL-Livewire-Scanner/1.0 Educational','YTo0OntzOjY6Il90b2tlbiI7czo0MDoiR0Y5YUc0R20zVXlJbURIUHNVeWNDV2p2MkluaDR0MTVIV0Zmd3pZbSI7czo2OiJsb2NhbGUiO3M6MjoiZW4iO3M6OToiX3ByZXZpb3VzIjthOjI6e3M6MzoidXJsIjtzOjMwOiJodHRwczovL2ZhbGNvbmV5ZWdwcy5jb20vbG9naW4iO3M6NToicm91dGUiO3M6NToibG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19',1780757743),('L6GKxAKsGdsCnbYlpPSKqP4jeE4IZRjcKYm5Px2R',NULL,'69.5.169.153','Mozilla/5.0 (compatible; Infrawatch/1.0; +https://infrawat.ch/)','YTo0OntzOjY6Il90b2tlbiI7czo0MDoiUzdEOGxMMjc0VzNrUVVMQ011a2ZlWjBFZXVzeTF1R1FzV1dLZThOZCI7czo2OiJsb2NhbGUiO3M6MjoiZW4iO3M6OToiX3ByZXZpb3VzIjthOjI6e3M6MzoidXJsIjtzOjIxOiJodHRwczovLzUyLjU3LjE2Ni4yMDUiO3M6NToicm91dGUiO3M6NDoiaG9tZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=',1780760845),('ozgdlTWoqDh225WSSb6TTwQ4OH0ibImTxAMhG8JB',NULL,'43.153.96.79','Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1','YTo0OntzOjY6Il90b2tlbiI7czo0MDoiNnY0Zm9WNUVGaFh5YlJQWXN6RWJGZEd1WTRVODhqYkZVd1ptS0F1dSI7czo2OiJsb2NhbGUiO3M6MjoiZW4iO3M6OToiX3ByZXZpb3VzIjthOjI6e3M6MzoidXJsIjtzOjIwOiJodHRwOi8vNTIuNTcuMTY2LjIwNSI7czo1OiJyb3V0ZSI7czo0OiJob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1780757927),('q5qKpK8g7NTDAe9fGCYURzY4WFoZHGXjblfozdq3',NULL,'109.105.194.6','LRVL-Livewire-Scanner/1.0 Educational','YTo0OntzOjY6Il90b2tlbiI7czo0MDoiSWpYR1lsSFpGc21TOVBzWE91NzhqRXlOcEdpZEFIWHU0aG1BZ3lsSCI7czo2OiJsb2NhbGUiO3M6MjoiZW4iO3M6OToiX3ByZXZpb3VzIjthOjI6e3M6MzoidXJsIjtzOjI0OiJodHRwczovL2ZhbGNvbmV5ZWdwcy5jb20iO3M6NToicm91dGUiO3M6NDoiaG9tZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=',1780757742),('S8gLZnWplnkrx21rMIFLT9W6MaRmVy2Gxkqpve2N',NULL,'17.241.227.4','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15 (Applebot/0.1; +http://www.apple.com/go/applebot)','YTo0OntzOjY6Il90b2tlbiI7czo0MDoib2hHRVhhQWNsQk5RZnJsOHhXV2ZERkxFOG1FSlVodlo3aWJ6RUdiaiI7czo2OiJsb2NhbGUiO3M6MjoiZW4iO3M6OToiX3ByZXZpb3VzIjthOjI6e3M6MzoidXJsIjtzOjMyOiJodHRwOi8vd3d3LmZhbGNvbmV5ZWdwcy5jb20vaGVscCI7czo1OiJyb3V0ZSI7czo0OiJoZWxwIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1780770365),('tBMGKYuRyxlgXnI2KpPMIq1gRUQDKB785kefe0yE',NULL,'17.241.227.4','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15 (Applebot/0.1; +http://www.apple.com/go/applebot)','YTo0OntzOjY6Il90b2tlbiI7czo0MDoiMjZiWnVsODZaQTgwTEV0aDFVVnU2QVVudHlrTW10dThUbG9sM2hFNyI7czo2OiJsb2NhbGUiO3M6MjoiZW4iO3M6OToiX3ByZXZpb3VzIjthOjI6e3M6MzoidXJsIjtzOjM4OiJodHRwOi8vd3d3LmZhbGNvbmV5ZWdwcy5jb20vcm9ib3RzLnR4dCI7czo1OiJyb3V0ZSI7czo2OiJyb2JvdHMiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19',1780770365),('TPevaZhjokbrDGjbvnbkMfgZV8surOmcO2IrQZDz',NULL,'157.245.202.123','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36','YTo0OntzOjY6Il90b2tlbiI7czo0MDoidm5OeXUxVTZRcE1JTDNPUlhtMHB3VjFlOTJZVFFRVlczcUxoUXVZViI7czo2OiJsb2NhbGUiO3M6MjoiZW4iO3M6OToiX3ByZXZpb3VzIjthOjI6e3M6MzoidXJsIjtzOjIzOiJodHRwOi8vZmFsY29uZXllZ3BzLmNvbSI7czo1OiJyb3V0ZSI7czo0OiJob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1780764671),('tpJss57kO32UccGRbG8Z3cTSaGPgpefuiPrK7rIr',NULL,'49.51.245.241','Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1','YTo0OntzOjY6Il90b2tlbiI7czo0MDoicm1CV0c1RXNKSEVjU0lYRmVqVlpTOURRbENHeUx2bVlONkNpRFYyTSI7czo2OiJsb2NhbGUiO3M6MjoiZW4iO3M6OToiX3ByZXZpb3VzIjthOjI6e3M6MzoidXJsIjtzOjI3OiJodHRwOi8vd3d3LmZhbGNvbmV5ZWdwcy5jb20iO3M6NToicm91dGUiO3M6NDoiaG9tZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=',1780765606),('ugwRwTn5SFRtK5IEJBtV30jiOSlqiawCUvt2y9HO',NULL,'47.254.69.213','curl/7.74.0','YTo0OntzOjY6Il90b2tlbiI7czo0MDoiMGwxNDdEWlE3TkJFdzd3djl6UTdaM2F6amxOWW9NdmxrOHZhaTdZWiI7czo2OiJsb2NhbGUiO3M6MjoiZW4iO3M6OToiX3ByZXZpb3VzIjthOjI6e3M6MzoidXJsIjtzOjIxOiJodHRwczovLzUyLjU3LjE2Ni4yMDUiO3M6NToicm91dGUiO3M6NDoiaG9tZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=',1780768831),('vDuCzHaK9cJhrQqe7RQ1eQICe0GaGxUZ43HDHKT0',NULL,'43.156.168.214','Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1','YTo0OntzOjY6Il90b2tlbiI7czo0MDoic00zTmJDVjc0NGVxZ3RDY1FqclpEQ2c2TmNONTU4a0VrY0V4YVNmWSI7czo2OiJsb2NhbGUiO3M6MjoiZW4iO3M6OToiX3ByZXZpb3VzIjthOjI6e3M6MzoidXJsIjtzOjIwOiJodHRwOi8vNTIuNTcuMTY2LjIwNSI7czo1OiJyb3V0ZSI7czo0OiJob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1780765177),('VGeG2tVrjypX5GKQ4YudEQniisohtiBfssPs8P7h',NULL,'139.155.126.16','Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1','YTo0OntzOjY6Il90b2tlbiI7czo0MDoieU15NkpnZEw0dTVnZ01oWlF2TmtHSEZIQVo0Nk10ck4xc21JZnpQRSI7czo2OiJsb2NhbGUiO3M6MjoiZW4iO3M6OToiX3ByZXZpb3VzIjthOjI6e3M6MzoidXJsIjtzOjI3OiJodHRwOi8vd3d3LmZhbGNvbmV5ZWdwcy5jb20iO3M6NToicm91dGUiO3M6NDoiaG9tZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=',1780759795),('VjwCYrMqTjqW0wRzzUyVL8PEbd1WwCgOXxqafxF3',NULL,'54.92.193.6','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36','YTo0OntzOjY6Il90b2tlbiI7czo0MDoiQmQ4ZVl0VGpEMGNxcWRKc0pZSG02Q3NMbkNPWEd6MVkzbGVSclYzcCI7czo2OiJsb2NhbGUiO3M6MjoiZW4iO3M6OToiX3ByZXZpb3VzIjthOjI6e3M6MzoidXJsIjtzOjMyOiJodHRwczovLzUyLjU3LjE2Ni4yMDUvcm9ib3RzLnR4dCI7czo1OiJyb3V0ZSI7czo2OiJyb2JvdHMiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19',1780765537),('wUr9guErXI4lptA9Uk9DiK7dTkLma3XkvL5x5WYT',NULL,'109.105.194.6','LRVL-Livewire-Scanner/1.0 Educational','YTo0OntzOjY6Il90b2tlbiI7czo0MDoicjlxM0ZXaGFKMFJjanc5V1Fwa0R5SnhRaUFaQWxiY2Z6a1BGeE81dyI7czo2OiJsb2NhbGUiO3M6MjoiZW4iO3M6OToiX3ByZXZpb3VzIjthOjI6e3M6MzoidXJsIjtzOjM1OiJodHRwczovL2ZhbGNvbmV5ZWdwcy5jb20vcm9ib3RzLnR4dCI7czo1OiJyb3V0ZSI7czo2OiJyb2JvdHMiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19',1780757744),('x2ve4SZ9LABNVW6TFIEyM7warTvx6wdptYFejNAW',NULL,'43.159.136.201','Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1','YTo0OntzOjY6Il90b2tlbiI7czo0MDoidERUb1ZsSVdDYUdQaTRXMlNiWlVmS1RSaHRtdlBaeGs5S2I2aWpzWSI7czo2OiJsb2NhbGUiO3M6MjoiZW4iO3M6OToiX3ByZXZpb3VzIjthOjI6e3M6MzoidXJsIjtzOjI3OiJodHRwOi8vd3d3LmZhbGNvbmV5ZWdwcy5jb20iO3M6NToicm91dGUiO3M6NDoiaG9tZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=',1780758315),('YBXmH8TYrffpV4PUa6D7WzunigmqLKPI9GMu1oa5',NULL,'202.180.17.162','','YTo0OntzOjY6Il90b2tlbiI7czo0MDoidlBuNGZsdWF5ZWpLY0xDRFNpWkNiM0NucFlNUVVLNVkwSThhbzhFRiI7czo2OiJsb2NhbGUiO3M6MjoiZW4iO3M6OToiX3ByZXZpb3VzIjthOjI6e3M6MzoidXJsIjtzOjIxOiJodHRwczovLzUyLjU3LjE2Ni4yMDUiO3M6NToicm91dGUiO3M6NDoiaG9tZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=',1780767718),('YrPLdoBWrZdFd08pIse7MAN9HBhVNeKBuom67m94',NULL,'198.235.24.46','Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity','YTo0OntzOjY6Il90b2tlbiI7czo0MDoickxiRkljb1hxdjlvN0R3TDJpZGVRampKMnRDSTNXdDMwQmNwNVQ1bCI7czo2OiJsb2NhbGUiO3M6MjoiZW4iO3M6OToiX3ByZXZpb3VzIjthOjI6e3M6MzoidXJsIjtzOjI4OiJodHRwczovL3d3dy5mYWxjb25leWVncHMuY29tIjtzOjU6InJvdXRlIjtzOjQ6ImhvbWUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19',1780765552),('zn0C0SuCizEYPJR3jVfYnwOLPwlOFEKGdJvBuhfp',NULL,'54.174.244.202','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36','YTo0OntzOjY6Il90b2tlbiI7czo0MDoiaWhKMTlpbmFjbFh0MXZvSXdiWDBQc3JUbGliVmp6dVlscDg2R0lxdSI7czo2OiJsb2NhbGUiO3M6MjoiZW4iO3M6OToiX3ByZXZpb3VzIjthOjI6e3M6MzoidXJsIjtzOjIwOiJodHRwOi8vNTIuNTcuMTY2LjIwNSI7czo1OiJyb3V0ZSI7czo0OiJob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1780765760);

/*Table structure for table `subscription_histories` */

DROP TABLE IF EXISTS `subscription_histories`;

CREATE TABLE `subscription_histories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `subscription_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `device_id` bigint unsigned DEFAULT NULL,
  `plan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `starts_at` date DEFAULT NULL,
  `ends_at` date DEFAULT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `archived_at` timestamp NOT NULL,
  `archived_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `subscription_histories_subscription_id_archived_at_index` (`subscription_id`,`archived_at`),
  KEY `subscription_histories_user_id_index` (`user_id`),
  KEY `subscription_histories_device_id_index` (`device_id`),
  KEY `subscription_histories_archived_by_index` (`archived_by`),
  CONSTRAINT `subscription_histories_subscription_id_foreign` FOREIGN KEY (`subscription_id`) REFERENCES `subscriptions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `subscription_histories` */

/*Table structure for table `subscription_plans` */

DROP TABLE IF EXISTS `subscription_plans`;

CREATE TABLE `subscription_plans` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `duration_months` smallint unsigned NOT NULL,
  `billing_cycle` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'monthly',
  `company_price` decimal(12,2) NOT NULL,
  `currency` char(3) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'USD',
  `features` json DEFAULT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `is_public` tinyint(1) NOT NULL DEFAULT '1',
  `sort_order` smallint unsigned NOT NULL DEFAULT '0',
  `created_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `subscription_plans_slug_unique` (`slug`),
  KEY `subscription_plans_status_is_public_sort_order_index` (`status`,`is_public`,`sort_order`),
  KEY `subscription_plans_created_by_index` (`created_by`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `subscription_plans` */

insert  into `subscription_plans`(`id`,`name`,`slug`,`description`,`duration_months`,`billing_cycle`,`company_price`,`currency`,`features`,`status`,`is_public`,`sort_order`,`created_by`,`created_at`,`updated_at`) values (2,'Standard','standard-monthly',NULL,1,'monthly',3.00,'USD','[\"Geofences\", \"Reports\"]','active',1,1,NULL,'2026-05-27 04:58:56','2026-05-29 06:10:37'),(3,'Premium','premium-yearly',NULL,12,'yearly',24.00,'USD','[\"Everything in Standard\", \"1-year history\", \"Priority support\", \"API access\"]','active',1,2,NULL,'2026-05-27 04:58:56','2026-05-29 06:13:45');

/*Table structure for table `subscriptions` */

DROP TABLE IF EXISTS `subscriptions`;

CREATE TABLE `subscriptions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `device_id` bigint unsigned DEFAULT NULL,
  `user_id` bigint unsigned NOT NULL,
  `plan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subscription_plan_id` bigint unsigned DEFAULT NULL,
  `client_id` bigint unsigned DEFAULT NULL,
  `starts_at` date DEFAULT NULL,
  `ends_at` date DEFAULT NULL,
  `status` enum('active','expired','cancelled') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `subscription_type` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'renew',
  `company_price` decimal(12,2) DEFAULT NULL,
  `selling_price` decimal(12,2) DEFAULT NULL,
  `device_unit_cost` decimal(12,2) DEFAULT NULL,
  `device_selling_price` decimal(12,2) DEFAULT NULL,
  `platform_invoice_id` bigint unsigned DEFAULT NULL,
  `client_invoice_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `subscriptions_user_id_index` (`user_id`),
  KEY `subscriptions_status_index` (`status`),
  KEY `subscriptions_device_id_index` (`device_id`),
  KEY `subscriptions_subscription_plan_id_foreign` (`subscription_plan_id`),
  KEY `subscriptions_client_id_foreign` (`client_id`),
  KEY `subscriptions_platform_invoice_id_foreign` (`platform_invoice_id`),
  KEY `subscriptions_client_invoice_id_foreign` (`client_invoice_id`),
  CONSTRAINT `subscriptions_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE SET NULL,
  CONSTRAINT `subscriptions_client_invoice_id_foreign` FOREIGN KEY (`client_invoice_id`) REFERENCES `billing_invoices` (`id`) ON DELETE SET NULL,
  CONSTRAINT `subscriptions_platform_invoice_id_foreign` FOREIGN KEY (`platform_invoice_id`) REFERENCES `billing_invoices` (`id`) ON DELETE SET NULL,
  CONSTRAINT `subscriptions_subscription_plan_id_foreign` FOREIGN KEY (`subscription_plan_id`) REFERENCES `subscription_plans` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `subscriptions` */

insert  into `subscriptions`(`id`,`device_id`,`user_id`,`plan`,`subscription_plan_id`,`client_id`,`starts_at`,`ends_at`,`status`,`subscription_type`,`company_price`,`selling_price`,`device_unit_cost`,`device_selling_price`,`platform_invoice_id`,`client_invoice_id`,`created_at`,`updated_at`) values (5,5,6,'Premium',3,2,'2026-05-29','2027-05-29','active','new',24.00,24.00,16.22,16.22,3,4,'2026-05-29 17:03:20','2026-05-29 17:03:20'),(6,6,7,'Premium',3,2,'2026-05-29','2027-05-29','active','new',24.00,24.00,16.22,16.22,5,6,'2026-05-30 01:53:09','2026-05-30 02:11:28'),(7,7,9,'Premium',3,2,'2026-06-05','2027-06-05','active','new',24.00,24.00,16.22,16.22,7,8,'2026-06-05 02:40:35','2026-06-05 02:40:35');

/*Table structure for table `tc_attributes` */

DROP TABLE IF EXISTS `tc_attributes`;

CREATE TABLE `tc_attributes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `description` varchar(4000) NOT NULL,
  `type` varchar(128) NOT NULL,
  `attribute` varchar(128) NOT NULL,
  `expression` varchar(4000) NOT NULL,
  `priority` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `tc_attributes` */

/*Table structure for table `tc_calendars` */

DROP TABLE IF EXISTS `tc_calendars`;

CREATE TABLE `tc_calendars` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `data` mediumblob NOT NULL,
  `attributes` varchar(4000) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `tc_calendars` */

/*Table structure for table `tc_commands` */

DROP TABLE IF EXISTS `tc_commands`;

CREATE TABLE `tc_commands` (
  `id` int NOT NULL AUTO_INCREMENT,
  `description` varchar(4000) NOT NULL,
  `type` varchar(128) NOT NULL,
  `textchannel` bit(1) NOT NULL DEFAULT b'0',
  `attributes` varchar(4000) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `tc_commands` */

/*Table structure for table `tc_commands_queue` */

DROP TABLE IF EXISTS `tc_commands_queue`;

CREATE TABLE `tc_commands_queue` (
  `id` int NOT NULL AUTO_INCREMENT,
  `deviceid` int NOT NULL,
  `type` varchar(128) NOT NULL,
  `textchannel` bit(1) NOT NULL DEFAULT b'0',
  `attributes` varchar(4000) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_commands_queue_deviceid` (`deviceid`),
  CONSTRAINT `fk_commands_queue_deviceid` FOREIGN KEY (`deviceid`) REFERENCES `tc_devices` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `tc_commands_queue` */

/*Table structure for table `tc_device_attribute` */

DROP TABLE IF EXISTS `tc_device_attribute`;

CREATE TABLE `tc_device_attribute` (
  `deviceid` int NOT NULL,
  `attributeid` int NOT NULL,
  KEY `fk_user_device_attribute_attributeid` (`attributeid`),
  KEY `fk_user_device_attribute_deviceid` (`deviceid`),
  CONSTRAINT `fk_user_device_attribute_attributeid` FOREIGN KEY (`attributeid`) REFERENCES `tc_attributes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_user_device_attribute_deviceid` FOREIGN KEY (`deviceid`) REFERENCES `tc_devices` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `tc_device_attribute` */

/*Table structure for table `tc_device_command` */

DROP TABLE IF EXISTS `tc_device_command`;

CREATE TABLE `tc_device_command` (
  `deviceid` int NOT NULL,
  `commandid` int NOT NULL,
  KEY `fk_device_command_commandid` (`commandid`),
  KEY `fk_device_command_deviceid` (`deviceid`),
  CONSTRAINT `fk_device_command_commandid` FOREIGN KEY (`commandid`) REFERENCES `tc_commands` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_device_command_deviceid` FOREIGN KEY (`deviceid`) REFERENCES `tc_devices` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `tc_device_command` */

/*Table structure for table `tc_device_driver` */

DROP TABLE IF EXISTS `tc_device_driver`;

CREATE TABLE `tc_device_driver` (
  `deviceid` int NOT NULL,
  `driverid` int NOT NULL,
  KEY `fk_device_driver_deviceid` (`deviceid`),
  KEY `fk_device_driver_driverid` (`driverid`),
  CONSTRAINT `fk_device_driver_deviceid` FOREIGN KEY (`deviceid`) REFERENCES `tc_devices` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_device_driver_driverid` FOREIGN KEY (`driverid`) REFERENCES `tc_drivers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `tc_device_driver` */

/*Table structure for table `tc_device_geofence` */

DROP TABLE IF EXISTS `tc_device_geofence`;

CREATE TABLE `tc_device_geofence` (
  `deviceid` int NOT NULL,
  `geofenceid` int NOT NULL,
  KEY `fk_device_geofence_deviceid` (`deviceid`),
  KEY `fk_device_geofence_geofenceid` (`geofenceid`),
  CONSTRAINT `fk_device_geofence_deviceid` FOREIGN KEY (`deviceid`) REFERENCES `tc_devices` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_device_geofence_geofenceid` FOREIGN KEY (`geofenceid`) REFERENCES `tc_geofences` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `tc_device_geofence` */

/*Table structure for table `tc_device_maintenance` */

DROP TABLE IF EXISTS `tc_device_maintenance`;

CREATE TABLE `tc_device_maintenance` (
  `deviceid` int NOT NULL,
  `maintenanceid` int NOT NULL,
  KEY `fk_device_maintenance_deviceid` (`deviceid`),
  KEY `fk_device_maintenance_maintenanceid` (`maintenanceid`),
  CONSTRAINT `fk_device_maintenance_deviceid` FOREIGN KEY (`deviceid`) REFERENCES `tc_devices` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_device_maintenance_maintenanceid` FOREIGN KEY (`maintenanceid`) REFERENCES `tc_maintenances` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `tc_device_maintenance` */

/*Table structure for table `tc_device_notification` */

DROP TABLE IF EXISTS `tc_device_notification`;

CREATE TABLE `tc_device_notification` (
  `deviceid` int NOT NULL,
  `notificationid` int NOT NULL,
  KEY `fk_device_notification_deviceid` (`deviceid`),
  KEY `fk_device_notification_notificationid` (`notificationid`),
  CONSTRAINT `fk_device_notification_deviceid` FOREIGN KEY (`deviceid`) REFERENCES `tc_devices` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_device_notification_notificationid` FOREIGN KEY (`notificationid`) REFERENCES `tc_notifications` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `tc_device_notification` */

/*Table structure for table `tc_device_order` */

DROP TABLE IF EXISTS `tc_device_order`;

CREATE TABLE `tc_device_order` (
  `deviceid` int NOT NULL,
  `orderid` int NOT NULL,
  KEY `fk_device_order_deviceid` (`deviceid`),
  KEY `fk_device_order_orderid` (`orderid`),
  CONSTRAINT `fk_device_order_deviceid` FOREIGN KEY (`deviceid`) REFERENCES `tc_devices` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_device_order_orderid` FOREIGN KEY (`orderid`) REFERENCES `tc_orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `tc_device_order` */

/*Table structure for table `tc_device_report` */

DROP TABLE IF EXISTS `tc_device_report`;

CREATE TABLE `tc_device_report` (
  `deviceid` int NOT NULL,
  `reportid` int NOT NULL,
  KEY `fk_device_report_deviceid` (`deviceid`),
  KEY `fk_device_report_reportid` (`reportid`),
  CONSTRAINT `fk_device_report_deviceid` FOREIGN KEY (`deviceid`) REFERENCES `tc_devices` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_device_report_reportid` FOREIGN KEY (`reportid`) REFERENCES `tc_reports` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `tc_device_report` */

/*Table structure for table `tc_devices` */

DROP TABLE IF EXISTS `tc_devices`;

CREATE TABLE `tc_devices` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `uniqueid` varchar(128) NOT NULL,
  `lastupdate` timestamp NULL DEFAULT NULL,
  `positionid` int DEFAULT NULL,
  `groupid` int DEFAULT NULL,
  `attributes` varchar(4000) DEFAULT NULL,
  `phone` varchar(128) DEFAULT NULL,
  `model` varchar(128) DEFAULT NULL,
  `contact` varchar(512) DEFAULT NULL,
  `category` varchar(128) DEFAULT NULL,
  `disabled` bit(1) DEFAULT b'0',
  `status` char(8) DEFAULT NULL,
  `expirationtime` timestamp NULL DEFAULT NULL,
  `motionstate` bit(1) DEFAULT b'0',
  `motiontime` timestamp NULL DEFAULT NULL,
  `motiondistance` double DEFAULT '0',
  `overspeedstate` bit(1) DEFAULT b'0',
  `overspeedtime` timestamp NULL DEFAULT NULL,
  `overspeedgeofenceid` int DEFAULT '0',
  `motionstreak` bit(1) DEFAULT b'0',
  `calendarid` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniqueid` (`uniqueid`),
  KEY `fk_devices_groupid` (`groupid`),
  KEY `idx_devices_uniqueid` (`uniqueid`),
  KEY `fk_devices_calendarid` (`calendarid`),
  CONSTRAINT `fk_devices_calendarid` FOREIGN KEY (`calendarid`) REFERENCES `tc_calendars` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `fk_devices_groupid` FOREIGN KEY (`groupid`) REFERENCES `tc_groups` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `tc_devices` */

insert  into `tc_devices`(`id`,`name`,`uniqueid`,`lastupdate`,`positionid`,`groupid`,`attributes`,`phone`,`model`,`contact`,`category`,`disabled`,`status`,`expirationtime`,`motionstate`,`motiontime`,`motiondistance`,`overspeedstate`,`overspeedtime`,`overspeedgeofenceid`,`motionstreak`,`calendarid`) values (5,'Swift VXL','867530912345678','2026-06-05 00:57:11',541,NULL,'{\"device_type\":\"gps_tracker\",\"laravel_device_status\":\"active\",\"vehicle_name\":\"Swift VXL\",\"vehicle_number\":\"ABC-1234\",\"vehicle_model\":\"Toyota Helix 2026\",\"vehicle_type\":\"car\",\"sim_type\":\"esim\",\"sim_number\":\"03000012345\",\"plate_type\":\"public_transfer\"}',NULL,NULL,NULL,'gps_tracker','\0','offline',NULL,'\0',NULL,0,'\0',NULL,0,'\0',NULL),(6,'v27','4089440001','2026-06-03 16:58:28',539,NULL,'{\"device_type\":\"gps_tracker\",\"laravel_device_status\":\"active\",\"vehicle_name\":\"v27\",\"vehicle_number\":\"v27-120001\",\"vehicle_model\":\"2026\",\"vehicle_type\":\"pickup\",\"sim_type\":\"nano\",\"sim_number\":\"03312343433\",\"plate_type\":\"public_transfer\"}',NULL,NULL,NULL,'gps_tracker','\0','offline',NULL,'\0',NULL,0,'\0',NULL,0,'\0',NULL),(7,'Tracking','867530912345671','2026-06-05 03:05:16',564,NULL,'{\"device_type\":\"gps_tracker\",\"laravel_device_status\":\"active\",\"vehicle_name\":\"Honda 125\",\"vehicle_number\":\"GH-3345\",\"vehicle_model\":\"2026\",\"vehicle_type\":\"motorcycle\",\"sim_type\":\"nano\",\"sim_number\":\"03003026824\",\"plate_type\":\"public_transfer\"}',NULL,NULL,NULL,'gps_tracker','\0',NULL,NULL,'\0',NULL,0,'\0',NULL,0,'\0',NULL);

/*Table structure for table `tc_drivers` */

DROP TABLE IF EXISTS `tc_drivers`;

CREATE TABLE `tc_drivers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `uniqueid` varchar(128) NOT NULL,
  `attributes` varchar(4000) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniqueid` (`uniqueid`),
  KEY `idx_drivers_uniqueid` (`uniqueid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `tc_drivers` */

/*Table structure for table `tc_events` */

DROP TABLE IF EXISTS `tc_events`;

CREATE TABLE `tc_events` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(128) NOT NULL,
  `eventtime` timestamp NULL DEFAULT NULL,
  `deviceid` int DEFAULT NULL,
  `positionid` int DEFAULT NULL,
  `geofenceid` int DEFAULT NULL,
  `attributes` varchar(4000) DEFAULT NULL,
  `maintenanceid` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `event_deviceid_servertime` (`deviceid`,`eventtime`)
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `tc_events` */

insert  into `tc_events`(`id`,`type`,`eventtime`,`deviceid`,`positionid`,`geofenceid`,`attributes`,`maintenanceid`) values (1,'running','2026-05-23 20:33:40',1,NULL,NULL,'{\"laravel_type\":\"running\",\"laravel_geofence_id\":null,\"title\":\"Vehicle running\",\"message\":\"VXL is moving at 40 km\\/h.\",\"speed\":40,\"latitude\":24.65529038990259,\"longitude\":46.78408226257913,\"meta\":[]}',NULL),(2,'deviceOnline','2026-05-24 03:49:57',3,NULL,NULL,'{}',NULL),(3,'deviceUnknown','2026-05-24 04:06:35',3,NULL,NULL,'{}',NULL),(4,'deviceOnline','2026-05-24 04:10:22',3,NULL,NULL,'{}',NULL),(5,'geofenceEnter','2026-05-24 04:27:26',3,NULL,1,'{\"laravel_type\":\"geofence_enter\",\"laravel_geofence_id\":1,\"title\":\"Entered geofence\",\"message\":\"V27-Zahid entered geofence \\\"Home\\\".\",\"speed\":null,\"latitude\":25.4587553,\"longitude\":68.7827501,\"meta\":[]}',NULL),(6,'deviceUnknown','2026-05-24 04:37:26',3,NULL,NULL,'{}',NULL),(7,'deviceOnline','2026-05-24 04:37:29',3,NULL,NULL,'{}',NULL),(8,'geofenceEnter','2026-05-24 04:27:29',3,192,1,'{}',NULL),(9,'deviceUnknown','2026-05-24 04:52:31',3,NULL,NULL,'{}',NULL),(10,'deviceOnline','2026-05-24 05:16:21',3,NULL,NULL,'{}',NULL),(11,'deviceUnknown','2026-05-24 05:26:27',3,NULL,NULL,'{}',NULL),(12,'deviceOnline','2026-05-24 06:07:05',4,NULL,NULL,'{}',NULL),(13,'deviceOnline','2026-05-24 06:12:29',3,NULL,NULL,'{}',NULL),(14,'deviceUnknown','2026-05-24 06:17:06',4,NULL,NULL,'{}',NULL),(15,'deviceUnknown','2026-05-24 06:27:27',3,NULL,NULL,'{}',NULL),(16,'deviceOnline','2026-05-24 06:43:08',4,NULL,NULL,'{}',NULL),(17,'geofenceEnter','2026-05-24 06:17:23',3,NULL,1,'{\"laravel_type\":\"geofence_enter\",\"laravel_geofence_id\":1,\"title\":\"Entered geofence\",\"message\":\"V27-Zahid entered geofence \\\"Home\\\".\",\"speed\":null,\"latitude\":25.4587236,\"longitude\":68.7826881,\"meta\":[]}',NULL),(18,'deviceUnknown','2026-05-24 07:22:27',4,NULL,NULL,'{}',NULL),(19,'deviceOnline','2026-05-24 08:05:59',4,NULL,NULL,'{}',NULL),(20,'deviceUnknown','2026-05-24 08:22:47',4,NULL,NULL,'{}',NULL),(21,'deviceOnline','2026-05-24 08:43:33',4,NULL,NULL,'{}',NULL),(22,'deviceUnknown','2026-05-24 09:26:18',4,NULL,NULL,'{}',NULL),(23,'deviceOnline','2026-05-24 09:27:40',4,NULL,NULL,'{}',NULL),(24,'deviceUnknown','2026-05-24 09:41:41',4,NULL,NULL,'{}',NULL),(25,'deviceOnline','2026-05-24 09:41:45',4,NULL,NULL,'{}',NULL),(26,'deviceUnknown','2026-05-24 10:07:45',4,NULL,NULL,'{}',NULL),(27,'deviceOnline','2026-05-24 10:47:25',4,NULL,NULL,'{}',NULL),(28,'deviceUnknown','2026-05-24 11:00:42',4,NULL,NULL,'{}',NULL),(29,'deviceOnline','2026-05-24 12:15:26',4,NULL,NULL,'{}',NULL),(30,'deviceUnknown','2026-05-24 12:37:31',4,NULL,NULL,'{}',NULL),(31,'deviceOnline','2026-05-24 12:50:45',4,NULL,NULL,'{}',NULL),(32,'deviceUnknown','2026-05-24 13:19:19',4,NULL,NULL,'{}',NULL),(33,'deviceOnline','2026-05-24 13:24:48',4,NULL,NULL,'{}',NULL),(34,'deviceUnknown','2026-05-24 13:34:48',4,NULL,NULL,'{}',NULL),(35,'deviceOnline','2026-05-24 13:39:28',4,NULL,NULL,'{}',NULL),(36,'deviceUnknown','2026-05-24 15:21:08',4,NULL,NULL,'{}',NULL),(37,'deviceOnline','2026-05-24 15:21:25',4,NULL,NULL,'{}',NULL),(38,'deviceUnknown','2026-05-24 15:42:29',4,NULL,NULL,'{}',NULL),(39,'deviceOnline','2026-05-25 03:52:03',4,NULL,NULL,'{}',NULL),(40,'deviceUnknown','2026-05-25 04:02:03',4,NULL,NULL,'{}',NULL),(41,'deviceOnline','2026-05-25 04:08:40',4,NULL,NULL,'{}',NULL),(42,'deviceUnknown','2026-05-25 04:18:44',4,NULL,NULL,'{}',NULL),(43,'deviceOnline','2026-05-25 04:58:03',4,NULL,NULL,'{}',NULL),(44,'deviceUnknown','2026-05-25 05:08:14',4,NULL,NULL,'{}',NULL),(45,'deviceOnline','2026-05-25 14:00:51',4,NULL,NULL,'{}',NULL),(46,'deviceUnknown','2026-05-25 14:10:51',4,NULL,NULL,'{}',NULL),(47,'geofenceEnter','2026-05-25 14:00:49',4,NULL,2,'{\"laravel_type\":\"geofence_enter\",\"laravel_geofence_id\":2,\"title\":\"Entered geofence\",\"message\":\"Zakir Device entered geofence \\\"New Geofence\\\".\",\"speed\":null,\"latitude\":25.4591568,\"longitude\":68.7825092,\"meta\":[]}',NULL),(48,'geofenceEnter','2026-05-25 14:00:49',4,NULL,2,'{\"laravel_type\":\"geofence_enter\",\"laravel_geofence_id\":2,\"title\":\"Entered geofence\",\"message\":\"Zakir Device entered geofence \\\"New Geofence\\\".\",\"speed\":null,\"latitude\":25.4591568,\"longitude\":68.7825092,\"meta\":[]}',NULL),(49,'geofenceEnter','2026-05-24 06:17:23',3,NULL,1,'{\"laravel_type\":\"geofence_enter\",\"laravel_geofence_id\":1,\"title\":\"Entered geofence\",\"message\":\"V27-Zahid entered geofence \\\"Home\\\".\",\"speed\":null,\"latitude\":25.4587236,\"longitude\":68.7826881,\"meta\":[]}',NULL),(50,'geofenceEnter','2026-05-25 14:00:49',4,NULL,2,'{\"laravel_type\":\"geofence_enter\",\"laravel_geofence_id\":2,\"title\":\"Entered geofence\",\"message\":\"Zakir Device entered geofence \\\"New Geofence\\\".\",\"speed\":null,\"latitude\":25.4591568,\"longitude\":68.7825092,\"meta\":[]}',NULL),(51,'geofenceEnter','2026-05-24 06:17:23',3,NULL,1,'{\"laravel_type\":\"geofence_enter\",\"laravel_geofence_id\":1,\"title\":\"Entered geofence\",\"message\":\"V27-Zahid entered geofence \\\"Home\\\".\",\"speed\":null,\"latitude\":25.4587236,\"longitude\":68.7826881,\"meta\":[]}',NULL),(52,'geofenceEnter','2026-05-25 14:00:49',4,NULL,2,'{\"laravel_type\":\"geofence_enter\",\"laravel_geofence_id\":2,\"title\":\"Entered geofence\",\"message\":\"Zakir Device entered geofence \\\"New Geofence\\\".\",\"speed\":null,\"latitude\":25.4591568,\"longitude\":68.7825092,\"meta\":[]}',NULL),(53,'geofenceEnter','2026-05-24 06:17:23',3,NULL,1,'{\"laravel_type\":\"geofence_enter\",\"laravel_geofence_id\":1,\"title\":\"Entered geofence\",\"message\":\"V27-Zahid entered geofence \\\"Home\\\".\",\"speed\":null,\"latitude\":25.4587236,\"longitude\":68.7826881,\"meta\":[]}',NULL),(54,'geofenceEnter','2026-05-25 14:00:49',4,NULL,2,'{\"laravel_type\":\"geofence_enter\",\"laravel_geofence_id\":2,\"title\":\"Entered geofence\",\"message\":\"Zakir Device entered geofence \\\"New Geofence\\\".\",\"speed\":null,\"latitude\":25.4591568,\"longitude\":68.7825092,\"meta\":[]}',NULL),(55,'geofenceEnter','2026-05-24 06:17:23',3,NULL,1,'{\"laravel_type\":\"geofence_enter\",\"laravel_geofence_id\":1,\"title\":\"Entered geofence\",\"message\":\"V27-Zahid entered geofence \\\"Home\\\".\",\"speed\":null,\"latitude\":25.4587236,\"longitude\":68.7826881,\"meta\":[]}',NULL),(56,'running','2026-05-29 17:06:00',5,NULL,NULL,'{\"laravel_type\":\"running\",\"laravel_geofence_id\":null,\"title\":\"Vehicle running\",\"message\":\"Traccar is moving at 35 km\\/h.\",\"speed\":35,\"latitude\":21.522136951685592,\"longitude\":39.15137697970338,\"meta\":[]}',NULL),(57,'slow_speed','2026-05-29 17:06:00',5,NULL,NULL,'{\"laravel_type\":\"slow_speed\",\"laravel_geofence_id\":null,\"title\":\"Slow speed\",\"message\":\"Traccar is moving slowly at 20 km\\/h.\",\"speed\":20,\"latitude\":21.524461645803704,\"longitude\":39.15098344431372,\"meta\":[]}',NULL),(58,'running','2026-05-29 17:06:00',5,NULL,NULL,'{\"laravel_type\":\"running\",\"laravel_geofence_id\":null,\"title\":\"Vehicle running\",\"message\":\"Traccar is moving at 40 km\\/h.\",\"speed\":40,\"latitude\":21.52914753032357,\"longitude\":39.15818514194455,\"meta\":[]}',NULL),(59,'deviceOverspeed','2026-05-29 17:06:00',5,NULL,NULL,'{\"laravel_type\":\"overspeed\",\"laravel_geofence_id\":null,\"title\":\"Overspeed\",\"message\":\"Traccar exceeded 80 km\\/h limit (current 120 km\\/h).\",\"speed\":120,\"latitude\":21.531362290341487,\"longitude\":39.16654776905835,\"meta\":[]}',NULL),(60,'running','2026-05-29 17:06:00',5,NULL,NULL,'{\"laravel_type\":\"running\",\"laravel_geofence_id\":null,\"title\":\"Vehicle running\",\"message\":\"Traccar is moving at 40 km\\/h.\",\"speed\":40,\"latitude\":21.533693808742072,\"longitude\":39.17439886912773,\"meta\":[]}',NULL),(61,'stopped','2026-05-29 17:06:00',5,NULL,NULL,'{\"laravel_type\":\"stopped\",\"laravel_geofence_id\":null,\"title\":\"Vehicle stopped\",\"message\":\"Traccar has stopped (speed 0 km\\/h).\",\"speed\":0,\"latitude\":21.53276424765469,\"longitude\":39.17460974552504,\"meta\":[]}',NULL),(62,'deviceOnline','2026-05-29 21:51:18',6,NULL,NULL,'{}',NULL),(63,'deviceUnknown','2026-05-29 22:11:26',6,NULL,NULL,'{}',NULL),(64,'deviceOnline','2026-05-30 06:01:54',6,NULL,NULL,'{}',NULL),(65,'deviceUnknown','2026-05-30 06:11:55',6,NULL,NULL,'{}',NULL),(66,'deviceOnline','2026-05-30 07:05:05',6,NULL,NULL,'{}',NULL),(67,'deviceUnknown','2026-05-30 07:15:20',6,NULL,NULL,'{}',NULL),(68,'stopped','2026-05-29 17:06:00',5,NULL,NULL,'{\"laravel_type\":\"stopped\",\"laravel_geofence_id\":null,\"title\":\"Vehicle stopped\",\"message\":\"Swift VXL has stopped (speed 0 km\\/h).\",\"speed\":0,\"latitude\":21.53276424765469,\"longitude\":39.17460974552504,\"meta\":[]}',NULL),(69,'running','2026-05-29 17:06:00',5,NULL,NULL,'{\"laravel_type\":\"running\",\"laravel_geofence_id\":null,\"title\":\"Vehicle running\",\"message\":\"Swift VXL is moving at 40 km\\/h.\",\"speed\":40,\"latitude\":21.52989486751327,\"longitude\":39.17525299124315,\"meta\":[]}',NULL),(70,'deviceOnline','2026-05-30 15:46:39',6,NULL,NULL,'{}',NULL),(71,'deviceUnknown','2026-05-30 15:57:30',6,NULL,NULL,'{}',NULL),(72,'deviceOverspeed','2026-05-31 13:11:45',5,NULL,NULL,'{\"laravel_type\":\"overspeed\",\"laravel_geofence_id\":null,\"title\":\"Overspeed\",\"message\":\"Swift VXL exceeded 80 km\\/h limit (current 85 km\\/h).\",\"speed\":85,\"latitude\":21.527640104164593,\"longitude\":39.174858925896515,\"meta\":[]}',NULL),(73,'deviceOnline','2026-06-03 16:58:28',6,NULL,NULL,'{}',NULL),(74,'deviceUnknown','2026-06-03 17:08:28',6,NULL,NULL,'{}',NULL),(75,'deviceOverspeed','2026-05-31 14:55:00',5,NULL,NULL,'{\"laravel_type\":\"overspeed\",\"laravel_geofence_id\":null,\"title\":\"Overspeed\",\"message\":\"Swift VXL · ABC-1234 exceeded 80 km\\/h limit (current 92 km\\/h).\",\"speed\":92,\"latitude\":21.53506901971865,\"longitude\":39.209210013826855,\"meta\":[]}',NULL),(76,'gsm_weak','2026-06-05 02:40:00',7,NULL,NULL,'{\"laravel_type\":\"gsm_weak\",\"laravel_geofence_id\":null,\"title\":\"GSM signal weak\",\"message\":\"Honda 125 · GH-3345 GSM signal is weak (5%).\",\"speed\":80,\"latitude\":25.46674379162715,\"longitude\":68.71868734214924,\"meta\":{\"gsm_signal\":5}}',NULL),(77,'running','2026-06-05 02:40:00',7,NULL,NULL,'{\"laravel_type\":\"running\",\"laravel_geofence_id\":null,\"title\":\"Vehicle running\",\"message\":\"Honda 125 · GH-3345 is moving at 80 km\\/h.\",\"speed\":80,\"latitude\":25.46674379162715,\"longitude\":68.71868734214924,\"meta\":[]}',NULL),(78,'deviceOverspeed','2026-06-05 02:45:59',7,NULL,NULL,'{\"laravel_type\":\"overspeed\",\"laravel_geofence_id\":null,\"title\":\"Overspeed\",\"message\":\"Honda 125 · GH-3345 exceeded 80 km\\/h limit (current 90 km\\/h).\",\"speed\":90,\"latitude\":25.467600942659608,\"longitude\":68.71831840242538,\"meta\":[]}',NULL),(79,'gsm_weak','2026-06-05 02:52:59',7,NULL,NULL,'{\"laravel_type\":\"gsm_weak\",\"laravel_geofence_id\":null,\"title\":\"GSM signal weak\",\"message\":\"Honda 125 · GH-3345 GSM signal is weak (5%).\",\"speed\":90,\"latitude\":25.46772564585598,\"longitude\":68.71960621510752,\"meta\":{\"gsm_signal\":5}}',NULL),(80,'gsm_weak','2026-06-05 03:02:59',7,NULL,NULL,'{\"laravel_type\":\"gsm_weak\",\"laravel_geofence_id\":null,\"title\":\"GSM signal weak\",\"message\":\"Honda 125 · GH-3345 GSM signal is weak (5%).\",\"speed\":90,\"latitude\":25.468011072901408,\"longitude\":68.72134364798487,\"meta\":{\"gsm_signal\":5}}',NULL),(81,'stopped','2026-06-05 03:04:59',7,NULL,NULL,'{\"laravel_type\":\"stopped\",\"laravel_geofence_id\":null,\"title\":\"Vehicle stopped\",\"message\":\"Honda 125 · GH-3345 has stopped (speed 1 km\\/h).\",\"speed\":1,\"latitude\":25.467095459217273,\"longitude\":68.72175498591199,\"meta\":[]}',NULL);

/*Table structure for table `tc_geofences` */

DROP TABLE IF EXISTS `tc_geofences`;

CREATE TABLE `tc_geofences` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `description` varchar(128) DEFAULT NULL,
  `area` varchar(4096) NOT NULL,
  `attributes` varchar(4000) DEFAULT NULL,
  `calendarid` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_geofence_calendar_calendarid` (`calendarid`),
  CONSTRAINT `fk_geofence_calendar_calendarid` FOREIGN KEY (`calendarid`) REFERENCES `tc_calendars` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `tc_geofences` */

insert  into `tc_geofences`(`id`,`name`,`description`,`area`,`attributes`,`calendarid`) values (1,'Home','circle','CIRCLE (25.458476 68.782601, 437.000000)','{\"type\":\"circle\",\"laravel_device_id\":3,\"center\":[25.458476403624424,68.7826006137469],\"radius\":437}',NULL),(2,'New Geofence','circle','CIRCLE (25.459852 68.783622, 2832.000000)','{\"type\":\"circle\",\"laravel_device_id\":4,\"center\":[25.45985242407266,68.7836222316638],\"radius\":2832}',NULL);

/*Table structure for table `tc_group_attribute` */

DROP TABLE IF EXISTS `tc_group_attribute`;

CREATE TABLE `tc_group_attribute` (
  `groupid` int NOT NULL,
  `attributeid` int NOT NULL,
  KEY `fk_group_attribute_attributeid` (`attributeid`),
  KEY `fk_group_attribute_groupid` (`groupid`),
  CONSTRAINT `fk_group_attribute_attributeid` FOREIGN KEY (`attributeid`) REFERENCES `tc_attributes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_group_attribute_groupid` FOREIGN KEY (`groupid`) REFERENCES `tc_groups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `tc_group_attribute` */

/*Table structure for table `tc_group_command` */

DROP TABLE IF EXISTS `tc_group_command`;

CREATE TABLE `tc_group_command` (
  `groupid` int NOT NULL,
  `commandid` int NOT NULL,
  KEY `fk_group_command_commandid` (`commandid`),
  KEY `fk_group_command_groupid` (`groupid`),
  CONSTRAINT `fk_group_command_commandid` FOREIGN KEY (`commandid`) REFERENCES `tc_commands` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_group_command_groupid` FOREIGN KEY (`groupid`) REFERENCES `tc_groups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `tc_group_command` */

/*Table structure for table `tc_group_driver` */

DROP TABLE IF EXISTS `tc_group_driver`;

CREATE TABLE `tc_group_driver` (
  `groupid` int NOT NULL,
  `driverid` int NOT NULL,
  KEY `fk_group_driver_driverid` (`driverid`),
  KEY `fk_group_driver_groupid` (`groupid`),
  CONSTRAINT `fk_group_driver_driverid` FOREIGN KEY (`driverid`) REFERENCES `tc_drivers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_group_driver_groupid` FOREIGN KEY (`groupid`) REFERENCES `tc_groups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `tc_group_driver` */

/*Table structure for table `tc_group_geofence` */

DROP TABLE IF EXISTS `tc_group_geofence`;

CREATE TABLE `tc_group_geofence` (
  `groupid` int NOT NULL,
  `geofenceid` int NOT NULL,
  KEY `fk_group_geofence_geofenceid` (`geofenceid`),
  KEY `fk_group_geofence_groupid` (`groupid`),
  CONSTRAINT `fk_group_geofence_geofenceid` FOREIGN KEY (`geofenceid`) REFERENCES `tc_geofences` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_group_geofence_groupid` FOREIGN KEY (`groupid`) REFERENCES `tc_groups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `tc_group_geofence` */

/*Table structure for table `tc_group_maintenance` */

DROP TABLE IF EXISTS `tc_group_maintenance`;

CREATE TABLE `tc_group_maintenance` (
  `groupid` int NOT NULL,
  `maintenanceid` int NOT NULL,
  KEY `fk_group_maintenance_groupid` (`groupid`),
  KEY `fk_group_maintenance_maintenanceid` (`maintenanceid`),
  CONSTRAINT `fk_group_maintenance_groupid` FOREIGN KEY (`groupid`) REFERENCES `tc_groups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_group_maintenance_maintenanceid` FOREIGN KEY (`maintenanceid`) REFERENCES `tc_maintenances` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `tc_group_maintenance` */

/*Table structure for table `tc_group_notification` */

DROP TABLE IF EXISTS `tc_group_notification`;

CREATE TABLE `tc_group_notification` (
  `groupid` int NOT NULL,
  `notificationid` int NOT NULL,
  KEY `fk_group_notification_groupid` (`groupid`),
  KEY `fk_group_notification_notificationid` (`notificationid`),
  CONSTRAINT `fk_group_notification_groupid` FOREIGN KEY (`groupid`) REFERENCES `tc_groups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_group_notification_notificationid` FOREIGN KEY (`notificationid`) REFERENCES `tc_notifications` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `tc_group_notification` */

/*Table structure for table `tc_group_order` */

DROP TABLE IF EXISTS `tc_group_order`;

CREATE TABLE `tc_group_order` (
  `groupid` int NOT NULL,
  `orderid` int NOT NULL,
  KEY `fk_group_order_groupid` (`groupid`),
  KEY `fk_group_order_orderid` (`orderid`),
  CONSTRAINT `fk_group_order_groupid` FOREIGN KEY (`groupid`) REFERENCES `tc_groups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_group_order_orderid` FOREIGN KEY (`orderid`) REFERENCES `tc_orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `tc_group_order` */

/*Table structure for table `tc_group_report` */

DROP TABLE IF EXISTS `tc_group_report`;

CREATE TABLE `tc_group_report` (
  `groupid` int NOT NULL,
  `reportid` int NOT NULL,
  KEY `fk_group_report_groupid` (`groupid`),
  KEY `fk_group_report_reportid` (`reportid`),
  CONSTRAINT `fk_group_report_groupid` FOREIGN KEY (`groupid`) REFERENCES `tc_groups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_group_report_reportid` FOREIGN KEY (`reportid`) REFERENCES `tc_reports` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `tc_group_report` */

/*Table structure for table `tc_groups` */

DROP TABLE IF EXISTS `tc_groups`;

CREATE TABLE `tc_groups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `groupid` int DEFAULT NULL,
  `attributes` varchar(4000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_groups_groupid` (`groupid`),
  CONSTRAINT `fk_groups_groupid` FOREIGN KEY (`groupid`) REFERENCES `tc_groups` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `tc_groups` */

/*Table structure for table `tc_keystore` */

DROP TABLE IF EXISTS `tc_keystore`;

CREATE TABLE `tc_keystore` (
  `id` int NOT NULL AUTO_INCREMENT,
  `publickey` mediumblob NOT NULL,
  `privatekey` mediumblob NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `tc_keystore` */

/*Table structure for table `tc_maintenances` */

DROP TABLE IF EXISTS `tc_maintenances`;

CREATE TABLE `tc_maintenances` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(4000) NOT NULL,
  `type` varchar(128) NOT NULL,
  `start` double NOT NULL DEFAULT '0',
  `period` double NOT NULL DEFAULT '0',
  `attributes` varchar(4000) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `tc_maintenances` */

/*Table structure for table `tc_notifications` */

DROP TABLE IF EXISTS `tc_notifications`;

CREATE TABLE `tc_notifications` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(128) NOT NULL,
  `attributes` varchar(4000) DEFAULT NULL,
  `always` bit(1) NOT NULL DEFAULT b'0',
  `calendarid` int DEFAULT NULL,
  `notificators` varchar(128) DEFAULT NULL,
  `commandid` int DEFAULT NULL,
  `description` varchar(4000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_notification_calendar_calendarid` (`calendarid`),
  KEY `fk_notifications_commandid` (`commandid`),
  CONSTRAINT `fk_notification_calendar_calendarid` FOREIGN KEY (`calendarid`) REFERENCES `tc_calendars` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `fk_notifications_commandid` FOREIGN KEY (`commandid`) REFERENCES `tc_commands` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `tc_notifications` */

/*Table structure for table `tc_orders` */

DROP TABLE IF EXISTS `tc_orders`;

CREATE TABLE `tc_orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `uniqueid` varchar(128) NOT NULL,
  `description` varchar(512) DEFAULT NULL,
  `fromaddress` varchar(512) DEFAULT NULL,
  `toaddress` varchar(512) DEFAULT NULL,
  `attributes` varchar(4000) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `tc_orders` */

/*Table structure for table `tc_positions` */

DROP TABLE IF EXISTS `tc_positions`;

CREATE TABLE `tc_positions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `protocol` varchar(128) DEFAULT NULL,
  `deviceid` int NOT NULL,
  `servertime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `devicetime` timestamp NOT NULL,
  `fixtime` timestamp NOT NULL,
  `valid` bit(1) NOT NULL,
  `latitude` double NOT NULL,
  `longitude` double NOT NULL,
  `altitude` float NOT NULL,
  `speed` float NOT NULL,
  `course` float NOT NULL,
  `address` varchar(512) DEFAULT NULL,
  `attributes` varchar(4000) DEFAULT NULL,
  `accuracy` double NOT NULL DEFAULT '0',
  `network` varchar(4000) DEFAULT NULL,
  `geofenceids` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `position_deviceid_fixtime` (`deviceid`,`fixtime`)
) ENGINE=InnoDB AUTO_INCREMENT=565 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `tc_positions` */

insert  into `tc_positions`(`id`,`protocol`,`deviceid`,`servertime`,`devicetime`,`fixtime`,`valid`,`latitude`,`longitude`,`altitude`,`speed`,`course`,`address`,`attributes`,`accuracy`,`network`,`geofenceids`) values (1,'laravel',1,'2026-05-23 20:33:40','2026-05-23 20:33:40','2026-05-23 20:33:40','',24.655290389903,46.784082262579,0,21.5983,120,NULL,'{\"battery\":85,\"ignition\":true,\"acc\":true,\"gsm\":78,\"sat\":12,\"odometer\":152340,\"powerCut\":false,\"alarm\":false,\"gpsFix\":\"fix\"}',0,NULL,NULL),(2,'osmand',3,'2026-05-24 03:49:57','2026-05-24 03:04:30','2026-05-24 03:04:30','',25.4588004,68.7826472,0,0,0,NULL,'{\"distance\":0.0,\"totalDistance\":0.0,\"motion\":false}',0,'null','null'),(3,'osmand',3,'2026-05-24 03:49:57','2026-05-24 03:04:30','2026-05-24 03:04:30','',25.4588004,68.7826472,0,0,0,NULL,'{\"distance\":0.0,\"totalDistance\":0.0,\"motion\":false}',0,'null','null'),(4,'osmand',3,'2026-05-24 03:49:58','2026-05-24 03:33:11','2026-05-24 03:33:11','',25.4587564,68.782659,0,0,0,NULL,'{\"distance\":5.039603253535558,\"totalDistance\":5.039603253535558,\"motion\":false}',0,'null','null'),(5,'osmand',3,'2026-05-24 03:49:58','2026-05-24 03:33:16','2026-05-24 03:33:16','',25.458675,68.7826317,0,0,0,NULL,'{\"distance\":9.467744087702794,\"totalDistance\":14.507347341238352,\"motion\":false}',0,'null','null'),(6,'osmand',3,'2026-05-24 03:49:58','2026-05-24 03:34:23','2026-05-24 03:34:23','',25.4587991,68.7826454,0,0,0,NULL,'{\"distance\":13.883204640911076,\"totalDistance\":28.39055198214943,\"motion\":false}',0,'null','null'),(7,'osmand',3,'2026-05-24 03:49:58','2026-05-24 03:34:24','2026-05-24 03:34:24','',25.4588583,68.7826483,0,0,0,NULL,'{\"distance\":6.59655669247309,\"totalDistance\":34.98710867462252,\"motion\":false}',0,'null','null'),(8,'osmand',3,'2026-05-24 03:49:58','2026-05-24 03:37:42','2026-05-24 03:37:42','',25.4587435,68.782655,0,0,0,NULL,'{\"distance\":12.797208079835649,\"totalDistance\":47.78431675445817,\"motion\":false}',0,'null','null'),(9,'osmand',3,'2026-05-24 03:49:59','2026-05-24 03:37:57','2026-05-24 03:37:57','',25.4587436,68.7826509,0,0,0,NULL,'{\"distance\":0.41224057763466426,\"totalDistance\":48.19655733209283,\"motion\":false}',0,'null','null'),(10,'osmand',3,'2026-05-24 03:49:59','2026-05-24 03:37:57','2026-05-24 03:37:57','',25.4587436,68.7826509,0,0,0,NULL,'{\"distance\":0.0,\"totalDistance\":48.19655733209283,\"motion\":false}',0,'null','null'),(11,'osmand',3,'2026-05-24 03:49:59','2026-05-24 03:37:57','2026-05-24 03:37:57','',25.4587436,68.7826509,0,0,0,NULL,'{\"distance\":0.0,\"totalDistance\":48.19655733209283,\"motion\":false}',0,'null','null'),(12,'osmand',3,'2026-05-24 03:49:59','2026-05-24 03:38:02','2026-05-24 03:38:02','',25.4587217,68.7826867,0,0,0,NULL,'{\"distance\":4.346349821977493,\"totalDistance\":52.54290715407032,\"motion\":false}',0,'null','null'),(13,'osmand',3,'2026-05-24 03:49:59','2026-05-24 03:46:32','2026-05-24 03:46:32','',25.4587623,68.7827287,0,0,0,NULL,'{\"distance\":6.184403545911829,\"totalDistance\":58.72731069998215,\"motion\":false}',0,'null','null'),(14,'osmand',3,'2026-05-24 03:50:00','2026-05-24 03:47:17','2026-05-24 03:47:17','',25.4587867,68.78271,0,0,0,NULL,'{\"distance\":3.303083867237541,\"totalDistance\":62.03039456721969,\"motion\":false}',0,'null','null'),(15,'osmand',3,'2026-05-24 03:50:00','2026-05-24 03:47:18','2026-05-24 03:47:18','',25.4587967,68.7827233,0,0,0,NULL,'{\"distance\":1.739592981788191,\"totalDistance\":63.76998754900788,\"motion\":false}',0,'null','null'),(16,'osmand',3,'2026-05-24 03:50:00','2026-05-24 03:47:18','2026-05-24 03:47:18','',25.4587967,68.7827233,0,0,0,NULL,'{\"distance\":0.0,\"totalDistance\":63.76998754900788,\"motion\":false}',0,'null','null'),(17,'osmand',3,'2026-05-24 03:50:00','2026-05-24 03:47:18','2026-05-24 03:47:18','',25.4587967,68.7827233,0,0,0,NULL,'{\"distance\":0.0,\"totalDistance\":63.76998754900788,\"motion\":false}',0,'null','null'),(18,'osmand',3,'2026-05-24 03:50:00','2026-05-24 03:47:19','2026-05-24 03:47:19','',25.4587967,68.782725,0,0,0,NULL,'{\"distance\":0.17086661260806685,\"totalDistance\":63.940854161615945,\"motion\":false}',0,'null','null'),(19,'osmand',3,'2026-05-24 03:50:01','2026-05-24 03:47:19','2026-05-24 03:47:19','',25.4587967,68.782725,0,0,0,NULL,'{\"distance\":0.0,\"totalDistance\":63.940854161615945,\"motion\":false}',0,'null','null'),(20,'osmand',3,'2026-05-24 03:50:01','2026-05-24 03:47:19','2026-05-24 03:47:19','',25.4587967,68.782725,0,0,0,NULL,'{\"distance\":0.0,\"totalDistance\":63.940854161615945,\"motion\":false}',0,'null','null'),(21,'osmand',3,'2026-05-24 03:50:01','2026-05-24 03:47:19','2026-05-24 03:47:19','',25.4587967,68.782725,0,0,0,NULL,'{\"distance\":0.0,\"totalDistance\":63.940854161615945,\"motion\":false}',0,'null','null'),(22,'osmand',3,'2026-05-24 03:50:01','2026-05-24 03:47:19','2026-05-24 03:47:19','',25.4587967,68.782725,0,0,0,NULL,'{\"distance\":0.0,\"totalDistance\":63.940854161615945,\"motion\":false}',0,'null','null'),(23,'osmand',3,'2026-05-24 03:50:01','2026-05-24 03:47:19','2026-05-24 03:47:19','',25.4587967,68.782725,0,0,0,NULL,'{\"distance\":0.0,\"totalDistance\":63.940854161615945,\"motion\":false}',0,'null','null'),(24,'osmand',3,'2026-05-24 03:50:01','2026-05-24 03:49:56','2026-05-24 03:49:56','',25.4587913,68.7827222,0,0,0,NULL,'{\"distance\":0.6637416141826894,\"totalDistance\":64.60459577579863,\"motion\":false}',0,'null','null'),(25,'osmand',3,'2026-05-24 03:50:02','2026-05-24 03:50:01','2026-05-24 03:50:01','',25.4588617,68.78254,0,0,0,NULL,'{\"distance\":19.91929478108991,\"totalDistance\":84.52389055688855,\"motion\":false}',0,'null','null'),(26,'osmand',3,'2026-05-24 03:50:10','2026-05-24 03:50:10','2026-05-24 03:50:10','',25.4588067,68.7829067,0,0,0,NULL,'{\"distance\":37.36199387019139,\"totalDistance\":121.88588442707993,\"motion\":false}',0,'null','null'),(27,'osmand',3,'2026-05-24 03:50:10','2026-05-24 03:50:10','2026-05-24 03:50:10','',25.4588067,68.7829067,0,0,0,NULL,'{\"distance\":0.0,\"totalDistance\":121.88588442707993,\"motion\":false}',0,'null','null'),(28,'osmand',3,'2026-05-24 03:50:11','2026-05-24 03:50:10','2026-05-24 03:50:10','',25.4588067,68.7829067,0,0,0,NULL,'{\"distance\":0.0,\"totalDistance\":121.88588442707993,\"motion\":false}',0,'null','null'),(29,'osmand',3,'2026-05-24 03:50:11','2026-05-24 03:50:10','2026-05-24 03:50:10','',25.4588067,68.7829067,0,0,0,NULL,'{\"distance\":0.0,\"totalDistance\":121.88588442707993,\"motion\":false}',0,'null','null'),(30,'osmand',3,'2026-05-24 03:50:11','2026-05-24 03:50:11','2026-05-24 03:50:11','',25.458775,68.7828183,0,0,0,NULL,'{\"distance\":9.560177486505728,\"totalDistance\":131.44606191358565,\"motion\":false}',0,'null','null'),(31,'osmand',3,'2026-05-24 03:55:16','2026-05-24 03:55:14','2026-05-24 03:55:14','',25.458768,68.7827589,0,0,0,NULL,'{\"distance\":6.020919633072888,\"totalDistance\":137.46698154665853,\"motion\":false}',0,'null','null'),(32,'osmand',3,'2026-05-24 03:55:38','2026-05-24 03:55:38','2026-05-24 03:55:38','',25.4587739,68.7827425,0,0,0,NULL,'{\"distance\":1.7743898265103768,\"totalDistance\":139.2413713731689,\"motion\":false}',0,'null','null'),(33,'osmand',3,'2026-05-24 03:56:34','2026-05-24 03:56:34','2026-05-24 03:56:34','',25.4587911,68.782645,0,0,0,NULL,'{\"distance\":9.98500151725268,\"totalDistance\":149.22637289042157,\"motion\":false}',0,'null','null'),(34,'osmand',3,'2026-05-24 03:56:35','2026-05-24 03:56:35','2026-05-24 03:56:35','',25.458801,68.782661,0,0,0,NULL,'{\"distance\":1.949540883802109,\"totalDistance\":151.1759137742237,\"motion\":false}',0,'null','null'),(35,'osmand',3,'2026-05-24 04:10:22','2026-05-24 04:00:19','2026-05-24 04:00:19','',25.4587844,68.7827335,0,0,0,NULL,'{\"distance\":7.517613651699432,\"totalDistance\":158.69352742592312,\"motion\":false}',0,'null','null'),(36,'osmand',3,'2026-05-24 04:10:22','2026-05-24 04:00:28','2026-05-24 04:00:28','',25.4587748,68.782726,0,0,0,NULL,'{\"distance\":1.3077840467425863,\"totalDistance\":160.00131147266572,\"motion\":false}',0,'null','null'),(37,'osmand',3,'2026-05-24 04:10:22','2026-05-24 04:00:31','2026-05-24 04:00:31','',25.4586925,68.7826666,0,0,0,NULL,'{\"distance\":10.935222564543137,\"totalDistance\":170.93653403720884,\"motion\":false}',0,'null','null'),(38,'osmand',3,'2026-05-24 04:10:22','2026-05-24 04:02:43','2026-05-24 04:02:43','',25.4587671,68.7827599,0,0,0,NULL,'{\"distance\":12.526068272610846,\"totalDistance\":183.4626023098197,\"motion\":false}',0,'null','null'),(39,'osmand',3,'2026-05-24 04:10:22','2026-05-24 04:02:48','2026-05-24 04:02:48','',25.4587559,68.7827255,0,0,0,NULL,'{\"distance\":3.675461799903024,\"totalDistance\":187.1380641097227,\"motion\":false}',0,'null','null'),(40,'osmand',3,'2026-05-24 04:10:23','2026-05-24 04:02:49','2026-05-24 04:02:49','',25.4587476,68.7827204,0,0,0,NULL,'{\"distance\":1.0566199270084904,\"totalDistance\":188.1946840367312,\"motion\":false}',0,'null','null'),(41,'osmand',3,'2026-05-24 04:10:23','2026-05-24 04:02:51','2026-05-24 04:02:51','',25.4587283,68.7827296,0,0,0,NULL,'{\"distance\":2.3390081542205774,\"totalDistance\":190.53369219095177,\"motion\":false}',0,'null','null'),(42,'osmand',3,'2026-05-24 04:10:23','2026-05-24 04:04:13','2026-05-24 04:04:13','',25.4587536,68.7826934,0,0,0,NULL,'{\"distance\":4.601127236340755,\"totalDistance\":195.1348194272925,\"motion\":false}',0,'null','null'),(43,'osmand',3,'2026-05-24 04:10:23','2026-05-24 04:04:17','2026-05-24 04:04:17','',25.4587651,68.7826958,0,0,0,NULL,'{\"distance\":1.3027028170797001,\"totalDistance\":196.43752224437222,\"motion\":false}',0,'null','null'),(44,'osmand',3,'2026-05-24 04:10:23','2026-05-24 04:04:18','2026-05-24 04:04:18','',25.4587526,68.7826981,0,0,0,NULL,'{\"distance\":1.4105655900064278,\"totalDistance\":197.84808783437865,\"motion\":false}',0,'null','null'),(45,'osmand',3,'2026-05-24 04:10:24','2026-05-24 04:04:22','2026-05-24 04:04:22','',25.4587417,68.7826981,0,0,0,NULL,'{\"distance\":1.2133824495888814,\"totalDistance\":199.06147028396754,\"motion\":false}',0,'null','null'),(46,'osmand',3,'2026-05-24 04:10:24','2026-05-24 04:05:42','2026-05-24 04:05:42','',25.4587739,68.7827851,0,0,0,NULL,'{\"distance\":9.450516435999287,\"totalDistance\":208.5119867199668,\"motion\":false}',0,'null','null'),(47,'osmand',3,'2026-05-24 04:10:24','2026-05-24 04:05:48','2026-05-24 04:05:48','',25.4587538,68.7827794,0,0,0,NULL,'{\"distance\":2.3097023122488904,\"totalDistance\":210.82168903221572,\"motion\":false}',0,'null','null'),(48,'osmand',3,'2026-05-24 04:10:25','2026-05-24 04:05:49','2026-05-24 04:05:49','',25.4587438,68.7827785,0,0,0,NULL,'{\"distance\":1.1168642275861287,\"totalDistance\":211.93855325980184,\"motion\":false}',0,'null','null'),(49,'osmand',3,'2026-05-24 04:10:25','2026-05-24 04:05:52','2026-05-24 04:05:52','',25.4587375,68.782786,0,0,0,NULL,'{\"distance\":1.0296065829061907,\"totalDistance\":212.96815984270802,\"motion\":false}',0,'null','null'),(50,'osmand',3,'2026-05-24 04:10:25','2026-05-24 04:05:54','2026-05-24 04:05:54','',25.4587692,68.7827511,0,0,0,NULL,'{\"distance\":4.975664073048927,\"totalDistance\":217.94382391575695,\"motion\":false}',0,'null','null'),(51,'osmand',3,'2026-05-24 04:10:25','2026-05-24 04:10:21','2026-05-24 04:10:21','',25.4587996,68.7826775,0,0,0,NULL,'{\"distance\":8.134833713716922,\"totalDistance\":226.07865762947387,\"motion\":false}',0,'null','null'),(52,'osmand',3,'2026-05-24 04:10:25','2026-05-24 04:10:24','2026-05-24 04:10:24','',25.4587989,68.7826752,0,0,0,NULL,'{\"distance\":0.24395246641925103,\"totalDistance\":226.3226100958931,\"motion\":false}',0,'null','null'),(53,'osmand',3,'2026-05-24 04:10:26','2026-05-24 04:10:24','2026-05-24 04:10:24','',25.4587989,68.7826752,0,0,0,NULL,'{\"distance\":0.0,\"totalDistance\":226.3226100958931,\"motion\":false}',0,'null','null'),(54,'osmand',3,'2026-05-24 04:10:46','2026-05-24 04:10:45','2026-05-24 04:10:45','',25.4587691,68.7827421,0,0,0,NULL,'{\"distance\":7.497879592166475,\"totalDistance\":233.82048968805958,\"motion\":false}',0,'null','null'),(55,'osmand',3,'2026-05-24 04:11:29','2026-05-24 04:11:28','2026-05-24 04:11:28','',25.4587823,68.7827383,0,0,0,NULL,'{\"distance\":1.5182434462814658,\"totalDistance\":235.33873313434106,\"motion\":false}',0,'null','null'),(56,'osmand',3,'2026-05-24 04:11:50','2026-05-24 04:11:50','2026-05-24 04:11:50','',25.4587922,68.7827112,0,0,0,NULL,'{\"distance\":2.9383177411495085,\"totalDistance\":238.27705087549057,\"motion\":false}',0,'null','null'),(57,'osmand',3,'2026-05-24 04:12:12','2026-05-24 04:12:11','2026-05-24 04:12:11','',25.4587667,68.7827609,0,0,0,NULL,'{\"distance\":5.745546325536227,\"totalDistance\":244.0225972010268,\"motion\":false}',0,'null','null'),(58,'osmand',3,'2026-05-24 04:12:20','2026-05-24 04:12:20','2026-05-24 04:12:20','',25.458748,68.7826716,0,0,0,NULL,'{\"distance\":9.213762982654472,\"totalDistance\":253.23636018368126,\"motion\":false}',0,'null','null'),(59,'osmand',3,'2026-05-24 04:12:21','2026-05-24 04:12:21','2026-05-24 04:12:21','',25.4587441,68.782725,0,0,0,NULL,'{\"distance\":5.384754148904912,\"totalDistance\":258.62111433258616,\"motion\":false}',0,'null','null'),(60,'osmand',3,'2026-05-24 04:12:23','2026-05-24 04:12:22','2026-05-24 04:12:22','',25.4587449,68.7827645,0,0,0,NULL,'{\"distance\":3.9711364177016453,\"totalDistance\":262.5922507502878,\"motion\":false}',0,'null','null'),(61,'osmand',3,'2026-05-24 04:12:23','2026-05-24 04:12:22','2026-05-24 04:12:22','',25.4587449,68.7827645,0,0,0,NULL,'{\"distance\":0.0,\"totalDistance\":262.5922507502878,\"motion\":false}',0,'null','null'),(62,'osmand',3,'2026-05-24 04:12:25','2026-05-24 04:12:25','2026-05-24 04:12:25','',25.458743,68.7827851,0,0,0,NULL,'{\"distance\":2.081277167253086,\"totalDistance\":264.67352791754087,\"motion\":false}',0,'null','null'),(63,'osmand',3,'2026-05-24 04:12:27','2026-05-24 04:12:27','2026-05-24 04:12:27','',25.4587431,68.7827897,0,0,0,NULL,'{\"distance\":0.46247915129437633,\"totalDistance\":265.1360070688352,\"motion\":false}',0,'null','null'),(64,'osmand',3,'2026-05-24 04:12:29','2026-05-24 04:12:29','2026-05-24 04:12:29','',25.4587406,68.7827923,0,0,0,NULL,'{\"distance\":0.3817606744724741,\"totalDistance\":265.5177677433077,\"motion\":false}',0,'null','null'),(65,'osmand',3,'2026-05-24 04:12:30','2026-05-24 04:12:30','2026-05-24 04:12:30','',25.4587398,68.7827905,0,0,0,NULL,'{\"distance\":0.20164846486002724,\"totalDistance\":265.7194162081677,\"motion\":false}',0,'null','null'),(66,'osmand',3,'2026-05-24 04:12:33','2026-05-24 04:12:32','2026-05-24 04:12:32','',25.4587393,68.7827588,0,0,0,NULL,'{\"distance\":3.1866474218741416,\"totalDistance\":268.9060636300418,\"motion\":false}',0,'null','null'),(67,'osmand',3,'2026-05-24 04:12:33','2026-05-24 04:12:33','2026-05-24 04:12:33','',25.4587351,68.7827005,0,0,0,NULL,'{\"distance\":5.87834539043233,\"totalDistance\":274.78440902047413,\"motion\":false}',0,'null','null'),(68,'osmand',3,'2026-05-24 04:12:35','2026-05-24 04:12:35','2026-05-24 04:12:35','',25.4587355,68.7827083,0,0,0,NULL,'{\"distance\":0.7852401346568416,\"totalDistance\":275.56964915513095,\"motion\":false}',0,'null','null'),(69,'osmand',3,'2026-05-24 04:12:37','2026-05-24 04:12:35','2026-05-24 04:12:35','',25.4587367,68.7827103,0,0,0,NULL,'{\"distance\":0.24135745296441766,\"totalDistance\":275.81100660809534,\"motion\":false}',0,'null','null'),(70,'osmand',3,'2026-05-24 04:12:38','2026-05-24 04:12:38','2026-05-24 04:12:35','',25.4587367,68.7827103,0,0,0,NULL,'{\"notificationToken\":\"chJhC0tsRpuwNNApEBJE-P:APA91bFfCqUbSvJddmKVPVfZVFUP6lPhT8ZxhWlD3Y81uGZ6VzYWZL0UzV2iNStkCdvq6San8bfTMHjTJ8adeaw2s42LmQNRlVqJ6KlA4NLsM6natTLCXWY\",\"distance\":0.0,\"totalDistance\":275.81100660809534,\"motion\":false}',0,'null','null'),(71,'osmand',3,'2026-05-24 04:13:01','2026-05-24 04:13:00','2026-05-24 04:13:00','',25.4587718,68.78275,0,0,0,NULL,'{\"distance\":5.58472146671149,\"totalDistance\":281.3957280748068,\"motion\":false}',0,'null','null'),(72,'osmand',3,'2026-05-24 04:13:38','2026-05-24 04:13:38','2026-05-24 04:13:38','',25.4587536,68.7827557,0,0,0,NULL,'{\"distance\":2.1054588156773595,\"totalDistance\":283.5011868904842,\"motion\":false}',0,'null','null'),(73,'osmand',3,'2026-05-24 04:13:39','2026-05-24 04:13:38','2026-05-24 04:13:38','',25.4587536,68.7827557,0,0,0,NULL,'{\"distance\":0.0,\"totalDistance\":283.5011868904842,\"motion\":false}',0,'null','null'),(74,'osmand',3,'2026-05-24 04:13:39','2026-05-24 04:13:38','2026-05-24 04:13:38','',25.4587536,68.7827557,0,0,0,NULL,'{\"distance\":0.0,\"totalDistance\":283.5011868904842,\"motion\":false}',0,'null','null'),(75,'osmand',3,'2026-05-24 04:13:40','2026-05-24 04:13:38','2026-05-24 04:13:38','',25.4587536,68.7827557,0,0,0,NULL,'{\"distance\":0.0,\"totalDistance\":283.5011868904842,\"motion\":false}',0,'null','null'),(76,'osmand',3,'2026-05-24 04:15:31','2026-05-24 04:15:30','2026-05-24 04:15:30','',25.4587711,68.7827402,0,0,0,NULL,'{\"distance\":2.4944172184838536,\"totalDistance\":285.99560410896805,\"motion\":false}',0,'null','null'),(77,'osmand',3,'2026-05-24 04:15:34','2026-05-24 04:15:34','2026-05-24 04:15:34','',25.4587893,68.7828006,0,0,0,NULL,'{\"distance\":6.399940620871555,\"totalDistance\":292.3955447298396,\"motion\":false}',0,'null','null'),(78,'osmand',3,'2026-05-24 04:19:40','2026-05-24 04:19:40','2026-05-24 04:19:40','',25.4587754,68.7827341,0,0,0,NULL,'{\"distance\":6.860669924690654,\"totalDistance\":299.25621465453025,\"motion\":false}',0,'null','null'),(79,'osmand',3,'2026-05-24 04:19:52','2026-05-24 04:19:52','2026-05-24 04:19:52','',25.4587177,68.7826789,0,0,0,NULL,'{\"distance\":8.4875517718423,\"totalDistance\":307.74376642637253,\"motion\":false}',0,'null','null'),(80,'osmand',3,'2026-05-24 04:24:37','2026-05-24 04:24:05','2026-05-24 04:24:05','',25.4587457,68.7826571,0,0,0,NULL,'{\"distance\":3.8100304820512485,\"totalDistance\":311.5537969084238,\"motion\":false}',0,'null','null'),(81,'osmand',3,'2026-05-24 04:24:37','2026-05-24 04:24:06','2026-05-24 04:24:06','',25.4587386,68.7826661,0,0,0,NULL,'{\"distance\":1.2012336515240944,\"totalDistance\":312.7550305599479,\"motion\":false}',0,'null','null'),(82,'osmand',3,'2026-05-24 04:24:38','2026-05-24 04:24:07','2026-05-24 04:24:07','',25.4587368,68.782669,0,0,0,NULL,'{\"distance\":0.353708749672987,\"totalDistance\":313.1087393096209,\"motion\":false}',0,'null','null'),(83,'osmand',3,'2026-05-24 04:24:38','2026-05-24 04:24:09','2026-05-24 04:24:09','',25.4587193,68.7825972,0,0,0,NULL,'{\"distance\":7.474921912940745,\"totalDistance\":320.58366122256166,\"motion\":false}',0,'null','null'),(84,'osmand',3,'2026-05-24 04:24:38','2026-05-24 04:24:11','2026-05-24 04:24:11','',25.4587051,68.7825424,0,0,0,NULL,'{\"distance\":5.730281406365462,\"totalDistance\":326.3139426289271,\"motion\":false}',0,'null','null'),(85,'osmand',3,'2026-05-24 04:24:38','2026-05-24 04:24:13','2026-05-24 04:24:13','',25.4587043,68.782519,0,0,0,NULL,'{\"distance\":2.3536159042543168,\"totalDistance\":328.6675585331814,\"motion\":false}',0,'null','null'),(86,'osmand',3,'2026-05-24 04:24:38','2026-05-24 04:24:15','2026-05-24 04:24:15','',25.4586967,68.7825259,0,0,0,NULL,'{\"distance\":1.0939519136344644,\"totalDistance\":329.76151044681586,\"motion\":false}',0,'null','null'),(87,'osmand',3,'2026-05-24 04:24:39','2026-05-24 04:24:17','2026-05-24 04:24:17','',25.4586958,68.7825164,0,0,0,NULL,'{\"distance\":0.9600853634152485,\"totalDistance\":330.7215958102311,\"motion\":false}',0,'null','null'),(88,'osmand',3,'2026-05-24 04:24:40','2026-05-24 04:24:18','2026-05-24 04:24:18','',25.458691,68.7825111,0,0,0,NULL,'{\"distance\":0.7545091365803439,\"totalDistance\":331.47610494681146,\"motion\":false}',0,'null','null'),(89,'osmand',3,'2026-05-24 04:24:40','2026-05-24 04:24:20','2026-05-24 04:24:20','',25.4586827,68.7825109,0,0,0,NULL,'{\"distance\":0.9241704222662628,\"totalDistance\":332.40027536907775,\"motion\":false}',0,'null','null'),(90,'osmand',3,'2026-05-24 04:24:41','2026-05-24 04:24:21','2026-05-24 04:24:21','',25.4586784,68.7825161,0,0,0,NULL,'{\"distance\":0.7087263350202039,\"totalDistance\":333.109001704098,\"motion\":false}',0,'null','null'),(91,'osmand',3,'2026-05-24 04:24:41','2026-05-24 04:24:23','2026-05-24 04:24:23','',25.4586911,68.7825368,0,0,0,NULL,'{\"distance\":2.515435594085742,\"totalDistance\":335.6244372981837,\"motion\":false}',0,'null','null'),(92,'osmand',3,'2026-05-24 04:24:42','2026-05-24 04:24:24','2026-05-24 04:24:24','',25.4586999,68.782537,0,0,0,NULL,'{\"distance\":0.9798177470017779,\"totalDistance\":336.6042550451855,\"motion\":false}',0,'null','null'),(93,'osmand',3,'2026-05-24 04:24:42','2026-05-24 04:24:25','2026-05-24 04:24:25','',25.4587061,68.7825342,0,0,0,NULL,'{\"distance\":0.7453529901365069,\"totalDistance\":337.349608035322,\"motion\":false}',0,'null','null'),(94,'osmand',3,'2026-05-24 04:24:42','2026-05-24 04:24:27','2026-05-24 04:24:27','',25.458719,68.7825617,0,0,0,NULL,'{\"distance\":3.1147981967810296,\"totalDistance\":340.464406232103,\"motion\":false}',0,'null','null'),(95,'osmand',3,'2026-05-24 04:24:43','2026-05-24 04:24:28','2026-05-24 04:24:28','',25.4587165,68.7825781,0,0,0,NULL,'{\"distance\":1.6716893564449982,\"totalDistance\":342.13609558854796,\"motion\":false}',0,'null','null'),(96,'osmand',3,'2026-05-24 04:24:44','2026-05-24 04:24:29','2026-05-24 04:24:29','',25.4587122,68.7825863,0,0,0,NULL,'{\"distance\":0.9531014837672888,\"totalDistance\":343.08919707231524,\"motion\":false}',0,'null','null'),(97,'osmand',3,'2026-05-24 04:24:44','2026-05-24 04:24:31','2026-05-24 04:24:31','',25.4586918,68.782581,0,0,0,NULL,'{\"distance\":2.3325604921115555,\"totalDistance\":345.4217575644268,\"motion\":false}',0,'null','null'),(98,'osmand',3,'2026-05-24 04:24:44','2026-05-24 04:24:33','2026-05-24 04:24:33','',25.4586903,68.7825865,0,0,0,NULL,'{\"distance\":0.577472583550861,\"totalDistance\":345.99923014797764,\"motion\":false}',0,'null','null'),(99,'osmand',3,'2026-05-24 04:24:45','2026-05-24 04:24:35','2026-05-24 04:24:35','',25.458695,68.7825879,0,0,0,NULL,'{\"distance\":0.5417935911443913,\"totalDistance\":346.541023739122,\"motion\":false}',0,'null','null'),(100,'osmand',3,'2026-05-24 04:24:45','2026-05-24 04:24:37','2026-05-24 04:24:37','',25.4586909,68.782587,0,0,0,NULL,'{\"distance\":0.46528788434661583,\"totalDistance\":347.0063116234686,\"motion\":false}',0,'null','null'),(101,'osmand',3,'2026-05-24 04:24:46','2026-05-24 04:24:39','2026-05-24 04:24:39','',25.4586837,68.7825803,0,0,0,NULL,'{\"distance\":1.046848608723795,\"totalDistance\":348.0531602321924,\"motion\":false}',0,'null','null'),(102,'osmand',3,'2026-05-24 04:24:46','2026-05-24 04:24:41','2026-05-24 04:24:41','',25.4586841,68.7825714,0,0,0,NULL,'{\"distance\":0.8956453663140188,\"totalDistance\":348.9488055985064,\"motion\":false}',0,'null','null'),(103,'osmand',3,'2026-05-24 04:24:47','2026-05-24 04:24:43','2026-05-24 04:24:43','',25.4586881,68.7825624,0,0,0,NULL,'{\"distance\":1.0082426920521264,\"totalDistance\":349.95704829055853,\"motion\":false}',0,'null','null'),(104,'osmand',3,'2026-05-24 04:24:47','2026-05-24 04:24:45','2026-05-24 04:24:45','',25.4586901,68.7825541,0,0,0,NULL,'{\"distance\":0.8634297337133883,\"totalDistance\":350.8204780242719,\"motion\":false}',0,'null','null'),(105,'osmand',3,'2026-05-24 04:24:47','2026-05-24 04:24:46','2026-05-24 04:24:46','',25.4586903,68.7825517,0,0,0,NULL,'{\"distance\":0.24224891860335074,\"totalDistance\":351.06272694287526,\"motion\":false}',0,'null','null'),(106,'osmand',3,'2026-05-24 04:24:48','2026-05-24 04:24:48','2026-05-24 04:24:48','',25.4586913,68.7825489,0,0,0,NULL,'{\"distance\":0.30264422821670245,\"totalDistance\":351.36537117109197,\"motion\":false}',0,'null','null'),(107,'osmand',3,'2026-05-24 04:24:51','2026-05-24 04:24:50','2026-05-24 04:24:50','',25.4586921,68.7825476,0,0,0,NULL,'{\"distance\":0.158125489301582,\"totalDistance\":351.52349666039356,\"motion\":false}',0,'null','null'),(108,'osmand',3,'2026-05-24 04:24:53','2026-05-24 04:24:52','2026-05-24 04:24:52','',25.4586917,68.7825465,0,0,0,NULL,'{\"distance\":0.11919071015553853,\"totalDistance\":351.6426873705491,\"motion\":false}',0,'null','null'),(109,'osmand',3,'2026-05-24 04:24:54','2026-05-24 04:24:54','2026-05-24 04:24:54','',25.4586972,68.7825168,0,0,0,NULL,'{\"distance\":3.0472834196972958,\"totalDistance\":354.6899707902464,\"motion\":false}',0,'null','null'),(110,'osmand',3,'2026-05-24 04:24:55','2026-05-24 04:24:55','2026-05-24 04:24:55','',25.4586978,68.7825075,0,0,0,NULL,'{\"distance\":0.9371249046364285,\"totalDistance\":355.6270956948828,\"motion\":false}',0,'null','null'),(111,'osmand',3,'2026-05-24 04:24:56','2026-05-24 04:24:56','2026-05-24 04:24:56','',25.4586977,68.7825066,0,0,0,NULL,'{\"distance\":0.09114124830938207,\"totalDistance\":355.7182369431922,\"motion\":false}',0,'null','null'),(112,'osmand',3,'2026-05-24 04:24:58','2026-05-24 04:24:58','2026-05-24 04:24:58','',25.4586958,68.7825063,0,0,0,NULL,'{\"distance\":0.21364556053631362,\"totalDistance\":355.9318825037285,\"motion\":false}',0,'null','null'),(113,'osmand',3,'2026-05-24 04:25:00','2026-05-24 04:25:00','2026-05-24 04:25:00','',25.4586901,68.7825061,0,0,0,NULL,'{\"distance\":0.634839438596294,\"totalDistance\":356.5667219423248,\"motion\":false}',0,'null','null'),(114,'osmand',3,'2026-05-24 04:25:02','2026-05-24 04:25:02','2026-05-24 04:25:02','',25.4586907,68.782516,0,0,0,NULL,'{\"distance\":0.9972867706951191,\"totalDistance\":357.5640087130199,\"motion\":false}',0,'null','null'),(115,'osmand',3,'2026-05-24 04:25:04','2026-05-24 04:25:04','2026-05-24 04:25:04','',25.4586893,68.7825231,0,0,0,NULL,'{\"distance\":0.7304395278818192,\"totalDistance\":358.2944482409017,\"motion\":false}',0,'null','null'),(116,'osmand',3,'2026-05-24 04:25:06','2026-05-24 04:25:06','2026-05-24 04:25:06','',25.4586854,68.7825244,0,0,0,NULL,'{\"distance\":0.45338232711711113,\"totalDistance\":358.7478305680188,\"motion\":false}',0,'null','null'),(117,'osmand',3,'2026-05-24 04:25:07','2026-05-24 04:25:07','2026-05-24 04:25:07','',25.4586839,68.7825236,0,0,0,NULL,'{\"distance\":0.1853307703234746,\"totalDistance\":358.93316133834225,\"motion\":false}',0,'null','null'),(118,'osmand',3,'2026-05-24 04:25:09','2026-05-24 04:25:09','2026-05-24 04:25:09','',25.4586763,68.7825118,0,0,0,NULL,'{\"distance\":1.4568454431790467,\"totalDistance\":360.39000678152127,\"motion\":false}',0,'null','null'),(119,'osmand',3,'2026-05-24 04:25:11','2026-05-24 04:25:11','2026-05-24 04:25:11','',25.4586684,68.7825007,0,0,0,NULL,'{\"distance\":1.4205924566393704,\"totalDistance\":361.81059923816065,\"motion\":false}',0,'null','null'),(120,'osmand',3,'2026-05-24 04:25:13','2026-05-24 04:25:13','2026-05-24 04:25:13','',25.4586684,68.7824887,0,0,0,NULL,'{\"distance\":1.2061185521414648,\"totalDistance\":363.0167177903021,\"motion\":false}',0,'null','null'),(121,'osmand',3,'2026-05-24 04:25:15','2026-05-24 04:25:15','2026-05-24 04:25:15','',25.4586658,68.7824828,0,0,0,NULL,'{\"distance\":0.659870407333042,\"totalDistance\":363.6765881976351,\"motion\":false}',0,'null','null'),(122,'osmand',3,'2026-05-24 04:25:17','2026-05-24 04:25:17','2026-05-24 04:25:17','',25.4586646,68.7824784,0,0,0,NULL,'{\"distance\":0.46197815722830127,\"totalDistance\":364.1385663548634,\"motion\":false}',0,'null','null'),(123,'osmand',3,'2026-05-24 04:25:19','2026-05-24 04:25:19','2026-05-24 04:25:19','',25.458664,68.7824745,0,0,0,NULL,'{\"distance\":0.3976382122688698,\"totalDistance\":364.5362045671323,\"motion\":false}',0,'null','null'),(124,'osmand',3,'2026-05-24 04:25:21','2026-05-24 04:25:21','2026-05-24 04:25:21','',25.4586633,68.7824701,0,0,0,NULL,'{\"distance\":0.4490561172514595,\"totalDistance\":364.9852606843838,\"motion\":false}',0,'null','null'),(125,'osmand',3,'2026-05-24 04:25:23','2026-05-24 04:25:23','2026-05-24 04:25:23','',25.4586631,68.7824663,0,0,0,NULL,'{\"distance\":0.3825859113672195,\"totalDistance\":365.367846595751,\"motion\":false}',0,'null','null'),(126,'osmand',3,'2026-05-24 04:25:25','2026-05-24 04:25:25','2026-05-24 04:25:25','',25.4586629,68.7824633,0,0,0,NULL,'{\"distance\":0.30235047791843034,\"totalDistance\":365.67019707366944,\"motion\":false}',0,'null','null'),(127,'osmand',3,'2026-05-24 04:25:26','2026-05-24 04:25:26','2026-05-24 04:25:26','',25.4586627,68.7824621,0,0,0,NULL,'{\"distance\":0.122649509282443,\"totalDistance\":365.7928465829519,\"motion\":false}',0,'null','null'),(128,'osmand',3,'2026-05-24 04:25:28','2026-05-24 04:25:28','2026-05-24 04:25:28','',25.4586625,68.7824602,0,0,0,NULL,'{\"distance\":0.1922622067318884,\"totalDistance\":365.98510878968375,\"motion\":false}',0,'null','null'),(129,'osmand',3,'2026-05-24 04:25:30','2026-05-24 04:25:30','2026-05-24 04:25:30','',25.4586624,68.7824591,0,0,0,NULL,'{\"distance\":0.11111987670220541,\"totalDistance\":366.09622866638597,\"motion\":false}',0,'null','null'),(130,'osmand',3,'2026-05-24 04:25:32','2026-05-24 04:25:32','2026-05-24 04:25:32','',25.4586619,68.7824583,0,0,0,NULL,'{\"distance\":0.09779283625296514,\"totalDistance\":366.1940215026389,\"motion\":false}',0,'null','null'),(131,'osmand',3,'2026-05-24 04:25:34','2026-05-24 04:25:34','2026-05-24 04:25:34','',25.4586616,68.7824571,0,0,0,NULL,'{\"distance\":0.1251499254425171,\"totalDistance\":366.31917142808146,\"motion\":false}',0,'null','null'),(132,'osmand',3,'2026-05-24 04:25:35','2026-05-24 04:25:35','2026-05-24 04:25:35','',25.4586612,68.7824565,0,0,0,NULL,'{\"distance\":0.07496352469391199,\"totalDistance\":366.39413495277535,\"motion\":false}',0,'null','null'),(133,'osmand',3,'2026-05-24 04:25:37','2026-05-24 04:25:37','2026-05-24 04:25:37','',25.458661,68.782456,0,0,0,NULL,'{\"distance\":0.05496581145334938,\"totalDistance\":366.4491007642287,\"motion\":false}',0,'null','null'),(134,'osmand',3,'2026-05-24 04:25:39','2026-05-24 04:25:39','2026-05-24 04:25:39','',25.4586607,68.7824557,0,0,0,NULL,'{\"distance\":0.04499426553546215,\"totalDistance\":366.4940950297642,\"motion\":false}',0,'null','null'),(135,'osmand',3,'2026-05-24 04:25:41','2026-05-24 04:25:41','2026-05-24 04:25:41','',25.4586603,68.7824553,0,0,0,NULL,'{\"distance\":0.05999235486161822,\"totalDistance\":366.5540873846258,\"motion\":false}',0,'null','null'),(136,'osmand',3,'2026-05-24 04:25:43','2026-05-24 04:25:43','2026-05-24 04:25:43','',25.4586603,68.7824551,0,0,0,NULL,'{\"distance\":0.020101976031725362,\"totalDistance\":366.57418936065756,\"motion\":false}',0,'null','null'),(137,'osmand',3,'2026-05-24 04:25:45','2026-05-24 04:25:45','2026-05-24 04:25:45','',25.4586599,68.7824553,0,0,0,NULL,'{\"distance\":0.04885503108687006,\"totalDistance\":366.62304439174443,\"motion\":false}',0,'null','null'),(138,'osmand',3,'2026-05-24 04:25:47','2026-05-24 04:25:47','2026-05-24 04:25:47','',25.4586608,68.7824564,0,0,0,NULL,'{\"distance\":0.1492020464070843,\"totalDistance\":366.7722464381515,\"motion\":false}',0,'null','null'),(139,'osmand',3,'2026-05-24 04:25:49','2026-05-24 04:25:49','2026-05-24 04:25:49','',25.458661,68.7824569,0,0,0,NULL,'{\"distance\":0.05496581136951691,\"totalDistance\":366.82721224952104,\"motion\":false}',0,'null','null'),(140,'osmand',3,'2026-05-24 04:25:51','2026-05-24 04:25:51','2026-05-24 04:25:51','',25.4586618,68.7824568,0,0,0,NULL,'{\"distance\":0.08962098516660535,\"totalDistance\":366.91683323468766,\"motion\":false}',0,'null','null'),(141,'osmand',3,'2026-05-24 04:25:53','2026-05-24 04:25:53','2026-05-24 04:25:53','',25.4586616,68.7824564,0,0,0,NULL,'{\"distance\":0.045956926860008684,\"totalDistance\":366.9627901615477,\"motion\":false}',0,'null','null'),(142,'osmand',3,'2026-05-24 04:25:55','2026-05-24 04:25:55','2026-05-24 04:25:55','',25.4586614,68.7824562,0,0,0,NULL,'{\"distance\":0.029996177172101124,\"totalDistance\":366.9927863387198,\"motion\":false}',0,'null','null'),(143,'osmand',3,'2026-05-24 04:25:57','2026-05-24 04:25:57','2026-05-24 04:25:57','',25.4586615,68.7824551,0,0,0,NULL,'{\"distance\":0.1111198762347456,\"totalDistance\":367.1039062149545,\"motion\":false}',0,'null','null'),(144,'osmand',3,'2026-05-24 04:25:59','2026-05-24 04:25:59','2026-05-24 04:25:59','',25.4586618,68.7824555,0,0,0,NULL,'{\"distance\":0.05226509784263367,\"totalDistance\":367.15617131279714,\"motion\":false}',0,'null','null'),(145,'osmand',3,'2026-05-24 04:26:02','2026-05-24 04:26:01','2026-05-24 04:26:01','',25.4586621,68.7824554,0,0,0,NULL,'{\"distance\":0.034875564077430164,\"totalDistance\":367.19104687687457,\"motion\":false}',0,'null','null'),(146,'osmand',3,'2026-05-24 04:26:02','2026-05-24 04:26:02','2026-05-24 04:26:02','',25.4586623,68.7824562,0,0,0,NULL,'{\"distance\":0.08343328284456117,\"totalDistance\":367.27448015971913,\"motion\":false}',0,'null','null'),(147,'osmand',3,'2026-05-24 04:26:04','2026-05-24 04:26:04','2026-05-24 04:26:04','',25.4586618,68.7824565,0,0,0,NULL,'{\"distance\":0.06330251608368312,\"totalDistance\":367.3377826758028,\"motion\":false}',0,'null','null'),(148,'osmand',3,'2026-05-24 04:26:06','2026-05-24 04:26:06','2026-05-24 04:26:06','',25.4586622,68.7824562,0,0,0,NULL,'{\"distance\":0.05377662988772486,\"totalDistance\":367.3915593056906,\"motion\":false}',0,'null','null'),(149,'osmand',3,'2026-05-24 04:26:08','2026-05-24 04:26:08','2026-05-24 04:26:08','',25.4586853,68.7825719,0,0,0,NULL,'{\"distance\":11.90991090426304,\"totalDistance\":379.3014702099536,\"motion\":false}',0,'null','null'),(150,'osmand',3,'2026-05-24 04:26:11','2026-05-24 04:26:10','2026-05-24 04:26:10','',25.4586962,68.7826062,0,0,0,NULL,'{\"distance\":3.6547875472562783,\"totalDistance\":382.95625775720987,\"motion\":false}',0,'null','null'),(151,'osmand',3,'2026-05-24 04:26:12','2026-05-24 04:26:12','2026-05-24 04:26:12','',25.458705,68.7826274,0,0,0,NULL,'{\"distance\":2.3452047192136134,\"totalDistance\":385.30146247642347,\"motion\":false}',0,'null','null'),(152,'osmand',3,'2026-05-24 04:26:14','2026-05-24 04:26:14','2026-05-24 04:26:14','',25.4587118,68.7826555,0,0,0,NULL,'{\"distance\":2.924008990024382,\"totalDistance\":388.22547146644786,\"motion\":false}',0,'null','null'),(153,'osmand',3,'2026-05-24 04:26:16','2026-05-24 04:26:16','2026-05-24 04:26:16','',25.4587087,68.7826893,0,0,0,NULL,'{\"distance\":3.414714877366493,\"totalDistance\":391.6401863438144,\"motion\":false}',0,'null','null'),(154,'osmand',3,'2026-05-24 04:26:18','2026-05-24 04:26:18','2026-05-24 04:26:18','',25.4587121,68.7827174,0,0,0,NULL,'{\"distance\":2.8495741319720573,\"totalDistance\":394.48976047578645,\"motion\":false}',0,'null','null'),(155,'osmand',3,'2026-05-24 04:26:20','2026-05-24 04:26:20','2026-05-24 04:26:20','',25.4587213,68.7827388,0,0,0,NULL,'{\"distance\":2.382284105001584,\"totalDistance\":396.87204458078804,\"motion\":false}',0,'null','null'),(156,'osmand',3,'2026-05-24 04:26:22','2026-05-24 04:26:22','2026-05-24 04:26:22','',25.4587325,68.7827471,0,0,0,NULL,'{\"distance\":1.5001328177440103,\"totalDistance\":398.3721773985321,\"motion\":false}',0,'null','null'),(157,'osmand',3,'2026-05-24 04:26:24','2026-05-24 04:26:24','2026-05-24 04:26:24','',25.4587414,68.7827467,0,0,0,NULL,'{\"distance\":0.9915588613576447,\"totalDistance\":399.3637362598897,\"motion\":false}',0,'null','null'),(158,'osmand',3,'2026-05-24 04:26:26','2026-05-24 04:26:26','2026-05-24 04:26:26','',25.4587448,68.7827474,0,0,0,NULL,'{\"distance\":0.3849700573855478,\"totalDistance\":399.74870631727526,\"motion\":false}',0,'null','null'),(159,'osmand',3,'2026-05-24 04:26:28','2026-05-24 04:26:28','2026-05-24 04:26:28','',25.4587477,68.7827489,0,0,0,NULL,'{\"distance\":0.35629617618915027,\"totalDistance\":400.10500249346444,\"motion\":false}',0,'null','null'),(160,'osmand',3,'2026-05-24 04:26:30','2026-05-24 04:26:30','2026-05-24 04:26:30','',25.4587508,68.7827531,0,0,0,NULL,'{\"distance\":0.5452436146516877,\"totalDistance\":400.6502461081161,\"motion\":false}',0,'null','null'),(161,'osmand',3,'2026-05-24 04:26:32','2026-05-24 04:26:32','2026-05-24 04:26:32','',25.4587532,68.7827565,0,0,0,NULL,'{\"distance\":0.4337738721250242,\"totalDistance\":401.0840199802411,\"motion\":false}',0,'null','null'),(162,'osmand',3,'2026-05-24 04:26:34','2026-05-24 04:26:34','2026-05-24 04:26:34','',25.458753,68.7827587,0,0,0,NULL,'{\"distance\":0.222239586302352,\"totalDistance\":401.3062595665435,\"motion\":false}',0,'null','null'),(163,'osmand',3,'2026-05-24 04:26:36','2026-05-24 04:26:36','2026-05-24 04:26:36','',25.4587478,68.782766,0,0,0,NULL,'{\"distance\":0.9345736347474309,\"totalDistance\":402.2408332012909,\"motion\":false}',0,'null','null'),(164,'osmand',3,'2026-05-24 04:26:38','2026-05-24 04:26:38','2026-05-24 04:26:38','',25.4587385,68.7827734,0,0,0,NULL,'{\"distance\":1.274748735790405,\"totalDistance\":403.5155819370813,\"motion\":false}',0,'null','null'),(165,'osmand',3,'2026-05-24 04:26:40','2026-05-24 04:26:40','2026-05-24 04:26:40','',25.4587266,68.7827846,0,0,0,NULL,'{\"distance\":1.7384068412689933,\"totalDistance\":405.25398877835033,\"motion\":false}',0,'null','null'),(166,'osmand',3,'2026-05-24 04:26:41','2026-05-24 04:26:41','2026-05-24 04:26:41','',25.4587197,68.7827894,0,0,0,NULL,'{\"distance\":0.907050055988893,\"totalDistance\":406.16103883433925,\"motion\":false}',0,'null','null'),(167,'osmand',3,'2026-05-24 04:26:43','2026-05-24 04:26:43','2026-05-24 04:26:43','',25.4587114,68.7827964,0,0,0,NULL,'{\"distance\":1.1613337368611367,\"totalDistance\":407.3223725712004,\"motion\":false}',0,'null','null'),(168,'osmand',3,'2026-05-24 04:26:45','2026-05-24 04:26:45','2026-05-24 04:26:45','',25.4587116,68.7828006,0,0,0,NULL,'{\"distance\":0.42272803840961665,\"totalDistance\":407.74510060961,\"motion\":false}',0,'null','null'),(169,'osmand',3,'2026-05-24 04:26:47','2026-05-24 04:26:47','2026-05-24 04:26:47','',25.4587172,68.7828106,0,0,0,NULL,'{\"distance\":1.1827243311052333,\"totalDistance\":408.92782494071525,\"motion\":false}',0,'null','null'),(170,'osmand',3,'2026-05-24 04:26:49','2026-05-24 04:26:49','2026-05-24 04:26:49','',25.4587173,68.7828111,0,0,0,NULL,'{\"distance\":0.05147307249836816,\"totalDistance\":408.9792980132136,\"motion\":false}',0,'null','null'),(171,'osmand',3,'2026-05-24 04:26:50','2026-05-24 04:26:50','2026-05-24 04:26:50','',25.4587226,68.7828057,0,0,0,NULL,'{\"distance\":0.8016689100533447,\"totalDistance\":409.780966923267,\"motion\":false}',0,'null','null'),(172,'osmand',3,'2026-05-24 04:26:52','2026-05-24 04:26:52','2026-05-24 04:26:52','',25.4587282,68.7827855,0,0,0,NULL,'{\"distance\":2.123847084653828,\"totalDistance\":411.90481400792083,\"motion\":false}',0,'null','null'),(173,'osmand',3,'2026-05-24 04:26:55','2026-05-24 04:26:54','2026-05-24 04:26:54','',25.4587331,68.7827682,0,0,0,NULL,'{\"distance\":1.8223686935269863,\"totalDistance\":413.7271827014478,\"motion\":false}',0,'null','null'),(174,'osmand',3,'2026-05-24 04:26:56','2026-05-24 04:26:56','2026-05-24 04:26:56','',25.4587295,68.7827582,0,0,0,NULL,'{\"distance\":1.0820458519561975,\"totalDistance\":414.809228553404,\"motion\":false}',0,'null','null'),(175,'osmand',3,'2026-05-24 04:26:57','2026-05-24 04:26:57','2026-05-24 04:26:57','',25.458726,68.7827524,0,0,0,NULL,'{\"distance\":0.7011713301127008,\"totalDistance\":415.5103998835167,\"motion\":false}',0,'null','null'),(176,'osmand',3,'2026-05-24 04:26:59','2026-05-24 04:26:59','2026-05-24 04:26:59','',25.4587365,68.7827448,0,0,0,NULL,'{\"distance\":1.3963257982416697,\"totalDistance\":416.90672568175836,\"motion\":false}',0,'null','null'),(177,'osmand',3,'2026-05-24 04:27:00','2026-05-24 04:27:00','2026-05-24 04:27:00','',25.458743,68.782746,0,0,0,NULL,'{\"distance\":0.73356010561644,\"totalDistance\":417.6402857873748,\"motion\":false}',0,'null','null'),(178,'osmand',3,'2026-05-24 04:27:02','2026-05-24 04:27:02','2026-05-24 04:27:02','',25.4587473,68.7827475,0,0,0,NULL,'{\"distance\":0.5018551767013891,\"totalDistance\":418.1421409640762,\"motion\":false}',0,'null','null'),(179,'osmand',3,'2026-05-24 04:27:04','2026-05-24 04:27:04','2026-05-24 04:27:04','',25.4587478,68.7827487,0,0,0,NULL,'{\"distance\":0.13283526553296326,\"totalDistance\":418.27497622960914,\"motion\":false}',0,'null','null'),(180,'osmand',3,'2026-05-24 04:27:06','2026-05-24 04:27:06','2026-05-24 04:27:06','',25.4587501,68.7827494,0,0,0,NULL,'{\"distance\":0.2655257472225715,\"totalDistance\":418.5405019768317,\"motion\":false}',0,'null','null'),(181,'osmand',3,'2026-05-24 04:27:07','2026-05-24 04:27:07','2026-05-24 04:27:07','',25.4587509,68.7827494,0,0,0,NULL,'{\"distance\":0.08905559248887235,\"totalDistance\":418.6295575693206,\"motion\":false}',0,'null','null'),(182,'osmand',3,'2026-05-24 04:27:09','2026-05-24 04:27:09','2026-05-24 04:27:09','',25.4587526,68.7827508,0,0,0,NULL,'{\"distance\":0.23582476308666725,\"totalDistance\":418.86538233240725,\"motion\":false}',0,'null','null'),(183,'osmand',3,'2026-05-24 04:27:11','2026-05-24 04:27:11','2026-05-24 04:27:11','',25.458753,68.7827502,0,0,0,NULL,'{\"distance\":0.07496348808340572,\"totalDistance\":418.9403458204907,\"motion\":false}',0,'null','null'),(184,'osmand',3,'2026-05-24 04:27:13','2026-05-24 04:27:13','2026-05-24 04:27:13','',25.4587539,68.7827505,0,0,0,NULL,'{\"distance\":0.10462668644854452,\"totalDistance\":419.04497250693925,\"motion\":false}',0,'null','null'),(185,'osmand',3,'2026-05-24 04:27:15','2026-05-24 04:27:15','2026-05-24 04:27:15','',25.4587544,68.7827512,0,0,0,NULL,'{\"distance\":0.08971117973304599,\"totalDistance\":419.1346836866723,\"motion\":false}',0,'null','null'),(186,'osmand',3,'2026-05-24 04:27:17','2026-05-24 04:27:17','2026-05-24 04:27:17','',25.4587551,68.7827516,0,0,0,NULL,'{\"distance\":0.08768380456420792,\"totalDistance\":419.2223674912365,\"motion\":false}',0,'null','null'),(187,'osmand',3,'2026-05-24 04:27:19','2026-05-24 04:27:19','2026-05-24 04:27:19','',25.4587548,68.7827502,0,0,0,NULL,'{\"distance\":0.1446223926562821,\"totalDistance\":419.3669898838928,\"motion\":false}',0,'null','null'),(188,'osmand',3,'2026-05-24 04:27:21','2026-05-24 04:27:21','2026-05-24 04:27:21','',25.4587548,68.782751,0,0,0,NULL,'{\"distance\":0.08040784670119486,\"totalDistance\":419.447397730594,\"motion\":false}',0,'null','null'),(189,'osmand',3,'2026-05-24 04:27:22','2026-05-24 04:27:22','2026-05-24 04:27:22','',25.4587548,68.7827512,0,0,0,NULL,'{\"distance\":0.020101961675298714,\"totalDistance\":419.4674996922693,\"motion\":false}',0,'null','null'),(190,'osmand',3,'2026-05-24 04:27:24','2026-05-24 04:27:24','2026-05-24 04:27:24','',25.4587554,68.7827509,0,0,0,NULL,'{\"distance\":0.07328253837238947,\"totalDistance\":419.5407822306417,\"motion\":false}',0,'null','null'),(191,'osmand',3,'2026-05-24 04:27:26','2026-05-24 04:27:26','2026-05-24 04:27:26','',25.4587553,68.7827501,0,0,0,NULL,'{\"distance\":0.08117476095148031,\"totalDistance\":419.62195699159315,\"motion\":false}',0,'null','null'),(192,'osmand',3,'2026-05-24 04:37:29','2026-05-24 04:27:29','2026-05-24 04:27:29','',25.4587552,68.7827512,0,0,0,NULL,'{\"distance\":0.11111979191630873,\"totalDistance\":419.73307678350943,\"motion\":false}',0,'null','[1]'),(193,'osmand',3,'2026-05-24 04:37:29','2026-05-24 04:27:29','2026-05-24 04:27:29','',25.4587544,68.7827512,0,0,0,NULL,'{\"distance\":0.08905559248887235,\"totalDistance\":419.8221323759983,\"motion\":false}',0,'null','[1]'),(194,'osmand',3,'2026-05-24 04:37:29','2026-05-24 04:27:31','2026-05-24 04:27:31','',25.4587543,68.7827523,0,0,0,NULL,'{\"distance\":0.1111197913178265,\"totalDistance\":419.93325216731614,\"motion\":false}',0,'null','[1]'),(195,'osmand',3,'2026-05-24 04:37:30','2026-05-24 04:27:33','2026-05-24 04:27:33','',25.4587515,68.7827594,0,0,0,NULL,'{\"distance\":0.7787210682354516,\"totalDistance\":420.71197323555157,\"motion\":false}',0,'null','[1]'),(196,'osmand',3,'2026-05-24 04:37:30','2026-05-24 04:27:34','2026-05-24 04:27:34','',25.4587491,68.7827616,0,0,0,NULL,'{\"distance\":0.34680375177379763,\"totalDistance\":421.05877698732536,\"motion\":false}',0,'null','[1]'),(197,'osmand',3,'2026-05-24 04:37:31','2026-05-24 04:27:39','2026-05-24 04:27:39','',25.4587442,68.7827649,0,0,0,NULL,'{\"distance\":0.638393156430791,\"totalDistance\":421.6971701437561,\"motion\":false}',0,'null','[1]'),(198,'osmand',3,'2026-05-24 04:37:31','2026-05-24 04:27:45','2026-05-24 04:27:45','',25.4587473,68.7827622,0,0,0,NULL,'{\"distance\":0.4390132161955365,\"totalDistance\":422.13618335995164,\"motion\":false}',0,'null','[1]'),(199,'osmand',3,'2026-05-24 04:37:31','2026-05-24 04:27:47','2026-05-24 04:27:47','',25.4587474,68.7827602,0,0,0,NULL,'{\"distance\":0.20132761973271582,\"totalDistance\":422.33751097968434,\"motion\":false}',0,'null','[1]'),(200,'osmand',3,'2026-05-24 04:37:31','2026-05-24 04:27:48','2026-05-24 04:27:48','',25.4587485,68.7827603,0,0,0,NULL,'{\"distance\":0.12286324646352306,\"totalDistance\":422.46037422614785,\"motion\":false}',0,'null','[1]'),(201,'osmand',3,'2026-05-24 04:37:31','2026-05-24 04:27:51','2026-05-24 04:27:51','',25.4587514,68.7827604,0,0,0,NULL,'{\"distance\":0.32298295077840566,\"totalDistance\":422.78335717692624,\"motion\":false}',0,'null','[1]'),(202,'osmand',3,'2026-05-24 04:37:31','2026-05-24 04:27:52','2026-05-24 04:27:52','',25.4587514,68.7827607,0,0,0,NULL,'{\"distance\":0.030152942650660163,\"totalDistance\":422.8135101195769,\"motion\":false}',0,'null','[1]'),(203,'osmand',3,'2026-05-24 04:37:32','2026-05-24 04:29:34','2026-05-24 04:29:34','',25.4587717,68.7827401,0,0,0,NULL,'{\"distance\":3.064899575997887,\"totalDistance\":425.8784096955748,\"motion\":false}',0,'null','[1]'),(204,'osmand',3,'2026-05-24 04:37:32','2026-05-24 04:29:42','2026-05-24 04:29:42','',25.458768,68.7827427,0,0,0,NULL,'{\"distance\":0.48778876246719965,\"totalDistance\":426.366198458042,\"motion\":false}',0,'null','[1]'),(205,'osmand',3,'2026-05-24 04:37:32','2026-05-24 04:29:47','2026-05-24 04:29:47','',25.4587679,68.7827429,0,0,0,NULL,'{\"distance\":0.02297844771264839,\"totalDistance\":426.38917690575465,\"motion\":false}',0,'null','[1]'),(206,'osmand',3,'2026-05-24 04:37:32','2026-05-24 04:33:15','2026-05-24 04:33:15','',25.4587706,68.7827584,0,0,0,NULL,'{\"distance\":1.5866303878672008,\"totalDistance\":427.97580729362187,\"motion\":false}',0,'null','[1]'),(207,'osmand',3,'2026-05-24 04:37:33','2026-05-24 04:34:00','2026-05-24 04:34:00','',25.4586388,68.782702,0,0,0,NULL,'{\"distance\":15.728944629208538,\"totalDistance\":443.7047519228304,\"motion\":false}',0,'null','[1]'),(208,'osmand',3,'2026-05-24 04:37:33','2026-05-24 04:34:10','2026-05-24 04:34:10','',25.4586492,68.782703,0,0,0,NULL,'{\"distance\":1.1620774931226054,\"totalDistance\":444.86682941595296,\"motion\":false}',0,'null','[1]'),(209,'osmand',3,'2026-05-24 04:37:34','2026-05-24 04:34:33','2026-05-24 04:34:33','',25.458653,68.7827882,0,0,0,NULL,'{\"distance\":8.5738845398399,\"totalDistance\":453.4407139557929,\"motion\":false}',0,'null','[1]'),(210,'osmand',3,'2026-05-24 04:37:34','2026-05-24 04:37:03','2026-05-24 04:37:03','',25.4586539,68.7826814,0,0,0,NULL,'{\"distance\":10.734923977298086,\"totalDistance\":464.17563793309097,\"motion\":false}',0,'null','[1]'),(211,'osmand',3,'2026-05-24 04:37:34','2026-05-24 04:37:09','2026-05-24 04:37:09','',25.45867,68.7826602,0,0,0,NULL,'{\"distance\":2.7843288624520848,\"totalDistance\":466.95996679554304,\"motion\":false}',0,'null','[1]'),(212,'osmand',3,'2026-05-24 04:37:34','2026-05-24 04:37:11','2026-05-24 04:37:11','',25.4586736,68.7826568,0,0,0,NULL,'{\"distance\":0.52667118375973,\"totalDistance\":467.48663797930277,\"motion\":false}',0,'null','[1]'),(213,'osmand',3,'2026-05-24 04:37:34','2026-05-24 04:37:21','2026-05-24 04:37:21','',25.458695,68.7826463,0,0,0,NULL,'{\"distance\":2.605537338462479,\"totalDistance\":470.0921753177652,\"motion\":false}',0,'null','[1]'),(214,'osmand',3,'2026-05-24 04:37:35','2026-05-24 04:37:32','2026-05-24 04:37:32','',25.4586782,68.7826926,0,0,0,NULL,'{\"distance\":5.015334654579043,\"totalDistance\":475.10750997234425,\"motion\":false}',0,'null','[1]'),(215,'osmand',3,'2026-05-24 04:37:35','2026-05-24 04:37:34','2026-05-24 04:37:34','',25.4586855,68.7826969,0,0,0,NULL,'{\"distance\":0.9204137798756844,\"totalDistance\":476.0279237522199,\"motion\":false}',0,'null','[1]'),(216,'osmand',3,'2026-05-24 04:37:36','2026-05-24 04:37:36','2026-05-24 04:37:36','',25.4586942,68.7827045,0,0,0,NULL,'{\"distance\":1.2334737978689572,\"totalDistance\":477.2613975500889,\"motion\":false}',0,'null','[1]'),(217,'osmand',3,'2026-05-24 04:37:38','2026-05-24 04:37:38','2026-05-24 04:37:38','',25.4586977,68.7827115,0,0,0,NULL,'{\"distance\":0.8042460363364687,\"totalDistance\":478.0656435864253,\"motion\":false}',0,'null','[1]'),(218,'osmand',3,'2026-05-24 04:37:40','2026-05-24 04:37:39','2026-05-24 04:37:39','',25.4586978,68.7827131,0,0,0,NULL,'{\"distance\":0.16120059285977137,\"totalDistance\":478.2268441792851,\"motion\":false}',0,'null','[1]'),(219,'osmand',3,'2026-05-24 04:37:40','2026-05-24 04:37:40','2026-05-24 04:37:40','',25.4586758,68.7827063,0,0,0,NULL,'{\"distance\":2.542610723557017,\"totalDistance\":480.7694549028421,\"motion\":false}',0,'null','[1]'),(220,'osmand',3,'2026-05-24 04:37:41','2026-05-24 04:37:41','2026-05-24 04:37:41','',25.4586715,68.7826997,0,0,0,NULL,'{\"distance\":0.8180354349490113,\"totalDistance\":481.5874903377911,\"motion\":false}',0,'null','[1]'),(221,'osmand',3,'2026-05-24 04:37:43','2026-05-24 04:37:43','2026-05-24 04:37:43','',25.4586569,68.782691,0,0,0,NULL,'{\"distance\":1.8455685281492018,\"totalDistance\":483.4330588659403,\"motion\":false}',0,'null','[1]'),(222,'osmand',3,'2026-05-24 04:37:45','2026-05-24 04:37:45','2026-05-24 04:37:45','',25.4586519,68.7826862,0,0,0,NULL,'{\"distance\":0.7365842070007693,\"totalDistance\":484.1696430729411,\"motion\":false}',0,'null','[1]'),(223,'osmand',3,'2026-05-24 04:37:47','2026-05-24 04:37:47','2026-05-24 04:37:47','',25.4586552,68.7826848,0,0,0,NULL,'{\"distance\":0.3933822356325505,\"totalDistance\":484.56302530857363,\"motion\":false}',0,'null','[1]'),(224,'osmand',3,'2026-05-24 04:37:49','2026-05-24 04:37:49','2026-05-24 04:37:49','',25.4586551,68.7826833,0,0,0,NULL,'{\"distance\":0.15117524875209346,\"totalDistance\":484.71420055732574,\"motion\":false}',0,'null','[1]'),(225,'osmand',3,'2026-05-24 04:37:51','2026-05-24 04:37:51','2026-05-24 04:37:51','',25.4586576,68.782682,0,0,0,NULL,'{\"distance\":0.3074458708225553,\"totalDistance\":485.0216464281483,\"motion\":false}',0,'null','[1]'),(226,'osmand',3,'2026-05-24 04:37:53','2026-05-24 04:37:53','2026-05-24 04:37:53','',25.4586614,68.7826799,0,0,0,NULL,'{\"distance\":0.4727491571489458,\"totalDistance\":485.49439558529724,\"motion\":false}',0,'null','[1]'),(227,'osmand',3,'2026-05-24 04:37:55','2026-05-24 04:37:55','2026-05-24 04:37:55','',25.4586642,68.7826787,0,0,0,NULL,'{\"distance\":0.3342165893889142,\"totalDistance\":485.82861217468616,\"motion\":false}',0,'null','[1]'),(228,'osmand',3,'2026-05-24 04:37:57','2026-05-24 04:37:57','2026-05-24 04:37:57','',25.4586665,68.7826769,0,0,0,NULL,'{\"distance\":0.31350451279306296,\"totalDistance\":486.14211668747924,\"motion\":false}',0,'null','[1]'),(229,'osmand',3,'2026-05-24 04:37:59','2026-05-24 04:37:59','2026-05-24 04:37:59','',25.4586693,68.7826758,0,0,0,NULL,'{\"distance\":0.33072225951950485,\"totalDistance\":486.47283894699876,\"motion\":false}',0,'null','[1]'),(230,'osmand',3,'2026-05-24 04:38:01','2026-05-24 04:38:01','2026-05-24 04:38:01','',25.4586706,68.7826745,0,0,0,NULL,'{\"distance\":0.19497514572570182,\"totalDistance\":486.6678140927245,\"motion\":false}',0,'null','[1]'),(231,'osmand',3,'2026-05-24 04:38:02','2026-05-24 04:38:02','2026-05-24 04:38:02','',25.4586725,68.7826737,0,0,0,NULL,'{\"distance\":0.2262756177781735,\"totalDistance\":486.89408971050267,\"motion\":false}',0,'null','[1]'),(232,'osmand',3,'2026-05-24 04:38:04','2026-05-24 04:38:04','2026-05-24 04:38:04','',25.4586742,68.7826787,0,0,0,NULL,'{\"distance\":0.5369998506511221,\"totalDistance\":487.4310895611538,\"motion\":false}',0,'null','[1]'),(233,'osmand',3,'2026-05-24 04:38:06','2026-05-24 04:38:06','2026-05-24 04:38:06','',25.4586764,68.7826887,0,0,0,NULL,'{\"distance\":1.0345051413091075,\"totalDistance\":488.4655947024629,\"motion\":false}',0,'null','[1]'),(234,'osmand',3,'2026-05-24 04:38:08','2026-05-24 04:38:08','2026-05-24 04:38:08','',25.4586772,68.7826909,0,0,0,NULL,'{\"distance\":0.23838144589893145,\"totalDistance\":488.70397614836185,\"motion\":false}',0,'null','[1]'),(235,'osmand',3,'2026-05-24 04:38:10','2026-05-24 04:38:10','2026-05-24 04:38:10','',25.4586806,68.7826958,0,0,0,NULL,'{\"distance\":0.6211332348200047,\"totalDistance\":489.3251093831818,\"motion\":false}',0,'null','[1]'),(236,'osmand',3,'2026-05-24 04:38:11','2026-05-24 04:38:11','2026-05-24 04:38:11','',25.4586806,68.7826962,0,0,0,NULL,'{\"distance\":0.040203948138522974,\"totalDistance\":489.36531333132035,\"motion\":false}',0,'null','[1]'),(237,'osmand',3,'2026-05-24 04:38:13','2026-05-24 04:38:13','2026-05-24 04:38:13','',25.4586811,68.782697,0,0,0,NULL,'{\"distance\":0.09779282575483347,\"totalDistance\":489.4631061570752,\"motion\":false}',0,'null','[1]'),(238,'osmand',3,'2026-05-24 04:38:15','2026-05-24 04:38:15','2026-05-24 04:38:15','',25.4586825,68.782698,0,0,0,NULL,'{\"distance\":0.18544705551583218,\"totalDistance\":489.648553212591,\"motion\":false}',0,'null','[1]'),(239,'osmand',3,'2026-05-24 04:38:18','2026-05-24 04:38:17','2026-05-24 04:38:17','',25.4586832,68.7826985,0,0,0,NULL,'{\"distance\":0.09272352768645452,\"totalDistance\":489.7412767402775,\"motion\":false}',0,'null','[1]'),(240,'osmand',3,'2026-05-24 04:38:19','2026-05-24 04:38:19','2026-05-24 04:38:19','',25.4586833,68.782699,0,0,0,NULL,'{\"distance\":0.051473086360288946,\"totalDistance\":489.79274982663776,\"motion\":false}',0,'null','[1]'),(241,'osmand',3,'2026-05-24 04:38:21','2026-05-24 04:38:21','2026-05-24 04:38:21','',25.4586845,68.7826998,0,0,0,NULL,'{\"distance\":0.1559164879909422,\"totalDistance\":489.9486663146287,\"motion\":false}',0,'null','[1]'),(242,'osmand',3,'2026-05-24 04:38:23','2026-05-24 04:38:23','2026-05-24 04:38:23','',25.4586851,68.7827007,0,0,0,NULL,'{\"distance\":0.1124452725516656,\"totalDistance\":490.0611115871804,\"motion\":false}',0,'null','[1]'),(243,'osmand',3,'2026-05-24 04:38:25','2026-05-24 04:38:25','2026-05-24 04:38:25','',25.4586858,68.7827014,0,0,0,NULL,'{\"distance\":0.10498660972364485,\"totalDistance\":490.16609819690404,\"motion\":false}',0,'null','[1]'),(244,'osmand',3,'2026-05-24 04:38:27','2026-05-24 04:38:27','2026-05-24 04:38:27','',25.4586868,68.7827019,0,0,0,NULL,'{\"distance\":0.12213757533904555,\"totalDistance\":490.28823577224307,\"motion\":false}',0,'null','[1]'),(245,'osmand',3,'2026-05-24 04:38:29','2026-05-24 04:38:29','2026-05-24 04:38:29','',25.4586873,68.7827028,0,0,0,NULL,'{\"distance\":0.10621118392739941,\"totalDistance\":490.39444695617044,\"motion\":false}',0,'null','[1]'),(246,'osmand',3,'2026-05-24 04:38:31','2026-05-24 04:38:31','2026-05-24 04:38:31','',25.4586883,68.7827032,0,0,0,NULL,'{\"distance\":0.11835702860591077,\"totalDistance\":490.5128039847763,\"motion\":false}',0,'null','[1]'),(247,'osmand',3,'2026-05-24 04:38:33','2026-05-24 04:38:33','2026-05-24 04:38:33','',25.4586879,68.7827037,0,0,0,NULL,'{\"distance\":0.06714374686794644,\"totalDistance\":490.57994773164427,\"motion\":false}',0,'null','[1]'),(248,'osmand',3,'2026-05-24 04:38:35','2026-05-24 04:38:35','2026-05-24 04:38:35','',25.4586882,68.7827044,0,0,0,NULL,'{\"distance\":0.07788052758667433,\"totalDistance\":490.65782825923094,\"motion\":false}',0,'null','[1]'),(249,'osmand',3,'2026-05-24 04:38:37','2026-05-24 04:38:36','2026-05-24 04:38:36','',25.4586883,68.7827047,0,0,0,NULL,'{\"distance\":0.03214220261697831,\"totalDistance\":490.6899704618479,\"motion\":false}',0,'null','[1]'),(250,'osmand',3,'2026-05-24 04:38:38','2026-05-24 04:38:37','2026-05-24 04:38:37','',25.4586886,68.7827052,0,0,0,NULL,'{\"distance\":0.06033937951615834,\"totalDistance\":490.75030984136407,\"motion\":false}',0,'null','[1]'),(251,'osmand',3,'2026-05-24 04:38:39','2026-05-24 04:38:39','2026-05-24 04:38:39','',25.458689,68.7827061,0,0,0,NULL,'{\"distance\":0.10082426782123308,\"totalDistance\":490.8511341091853,\"motion\":false}',0,'null','[1]'),(252,'osmand',3,'2026-05-24 04:38:41','2026-05-24 04:38:41','2026-05-24 04:38:41','',25.4586891,68.7827078,0,0,0,NULL,'{\"distance\":0.17122900405071392,\"totalDistance\":491.022363113236,\"motion\":false}',0,'null','[1]'),(253,'osmand',3,'2026-05-24 04:38:43','2026-05-24 04:38:43','2026-05-24 04:38:43','',25.4586899,68.7827091,0,0,0,NULL,'{\"distance\":0.158125492455595,\"totalDistance\":491.1804886056916,\"motion\":false}',0,'null','[1]'),(254,'osmand',3,'2026-05-24 04:38:44','2026-05-24 04:38:44','2026-05-24 04:38:44','',25.4586902,68.7827095,0,0,0,NULL,'{\"distance\":0.05226509054451527,\"totalDistance\":491.2327536962361,\"motion\":false}',0,'null','[1]'),(255,'osmand',3,'2026-05-24 04:38:46','2026-05-24 04:38:46','2026-05-24 04:38:46','',25.4586902,68.7827105,0,0,0,NULL,'{\"distance\":0.10050986090032804,\"totalDistance\":491.33326355713643,\"motion\":false}',0,'null','[1]'),(256,'osmand',3,'2026-05-24 04:38:48','2026-05-24 04:38:48','2026-05-24 04:38:48','',25.4586904,68.7827118,0,0,0,NULL,'{\"distance\":0.13254604384511984,\"totalDistance\":491.4658096009816,\"motion\":false}',0,'null','[1]'),(257,'osmand',3,'2026-05-24 04:38:50','2026-05-24 04:38:50','2026-05-24 04:38:50','',25.4586906,68.7827126,0,0,0,NULL,'{\"distance\":0.08343326472744828,\"totalDistance\":491.549242865709,\"motion\":false}',0,'null','[1]'),(258,'osmand',3,'2026-05-24 04:38:52','2026-05-24 04:38:52','2026-05-24 04:38:52','',25.4586907,68.7827134,0,0,0,NULL,'{\"distance\":0.08117480513221714,\"totalDistance\":491.6304176708412,\"motion\":false}',0,'null','[1]'),(259,'osmand',3,'2026-05-24 04:38:54','2026-05-24 04:38:54','2026-05-24 04:38:54','',25.4586908,68.7827149,0,0,0,NULL,'{\"distance\":0.1511752043041434,\"totalDistance\":491.78159287514535,\"motion\":false}',0,'null','[1]'),(260,'osmand',3,'2026-05-24 04:38:56','2026-05-24 04:38:56','2026-05-24 04:38:56','',25.4586906,68.7827158,0,0,0,NULL,'{\"distance\":0.09315840929572046,\"totalDistance\":491.87475128444106,\"motion\":false}',0,'null','[1]'),(261,'osmand',3,'2026-05-24 04:38:58','2026-05-24 04:38:58','2026-05-24 04:38:58','',25.4586902,68.7827168,0,0,0,NULL,'{\"distance\":0.1099316003732423,\"totalDistance\":491.9846828848143,\"motion\":false}',0,'null','[1]'),(262,'osmand',3,'2026-05-24 04:38:59','2026-05-24 04:38:59','2026-05-24 04:38:59','',25.4586899,68.7827171,0,0,0,NULL,'{\"distance\":0.04499426063256772,\"totalDistance\":492.02967714544684,\"motion\":false}',0,'null','[1]'),(263,'osmand',3,'2026-05-24 04:39:01','2026-05-24 04:39:01','2026-05-24 04:39:01','',25.4586893,68.7827175,0,0,0,NULL,'{\"distance\":0.077958243013458,\"totalDistance\":492.1076353884603,\"motion\":false}',0,'null','[1]'),(264,'osmand',3,'2026-05-24 04:39:03','2026-05-24 04:39:03','2026-05-24 04:39:03','',25.4586889,68.7827182,0,0,0,NULL,'{\"distance\":0.08326354865367862,\"totalDistance\":492.190898937114,\"motion\":false}',0,'null','[1]'),(265,'osmand',3,'2026-05-24 04:39:05','2026-05-24 04:39:05','2026-05-24 04:39:05','',25.4586886,68.7827191,0,0,0,NULL,'{\"distance\":0.09642660777230816,\"totalDistance\":492.2873255448863,\"motion\":false}',0,'null','[1]'),(266,'osmand',3,'2026-05-24 04:39:07','2026-05-24 04:39:07','2026-05-24 04:39:07','',25.4586886,68.7827196,0,0,0,NULL,'{\"distance\":0.050254931118301455,\"totalDistance\":492.3375804760046,\"motion\":false}',0,'null','[1]'),(267,'osmand',3,'2026-05-24 04:39:08','2026-05-24 04:39:08','2026-05-24 04:39:08','',25.4586884,68.7827199,0,0,0,NULL,'{\"distance\":0.03748175745917314,\"totalDistance\":492.3750622334637,\"motion\":false}',0,'null','[1]'),(268,'osmand',3,'2026-05-24 04:39:10','2026-05-24 04:39:10','2026-05-24 04:39:10','',25.4586879,68.7827202,0,0,0,NULL,'{\"distance\":0.06330251296876686,\"totalDistance\":492.4383647464325,\"motion\":false}',0,'null','[1]'),(269,'osmand',3,'2026-05-24 04:39:12','2026-05-24 04:39:12','2026-05-24 04:39:12','',25.4586886,68.7827203,0,0,0,NULL,'{\"distance\":0.07856918285889705,\"totalDistance\":492.5169339292914,\"motion\":false}',0,'null','[1]'),(270,'osmand',3,'2026-05-24 04:39:14','2026-05-24 04:39:14','2026-05-24 04:39:14','',25.458688,68.7827203,0,0,0,NULL,'{\"distance\":0.06679169446552584,\"totalDistance\":492.5837256237569,\"motion\":false}',0,'null','[1]'),(271,'osmand',3,'2026-05-24 04:39:16','2026-05-24 04:39:16','2026-05-24 04:39:16','',25.4586874,68.7827207,0,0,0,NULL,'{\"distance\":0.07795824334079572,\"totalDistance\":492.6616838670977,\"motion\":false}',0,'null','[1]'),(272,'osmand',3,'2026-05-24 04:39:17','2026-05-24 04:39:17','2026-05-24 04:39:17','',25.458688,68.782721,0,0,0,NULL,'{\"distance\":0.073282544733118,\"totalDistance\":492.7349664118308,\"motion\":false}',0,'null','[1]'),(273,'osmand',3,'2026-05-24 04:39:19','2026-05-24 04:39:19','2026-05-24 04:39:19','',25.4586877,68.7827215,0,0,0,NULL,'{\"distance\":0.060339379724835496,\"totalDistance\":492.7953057915556,\"motion\":false}',0,'null','[1]'),(274,'osmand',3,'2026-05-24 04:39:21','2026-05-24 04:39:21','2026-05-24 04:39:21','',25.4586871,68.7827214,0,0,0,NULL,'{\"distance\":0.06754371002672332,\"totalDistance\":492.86284950158233,\"motion\":false}',0,'null','[1]'),(275,'osmand',3,'2026-05-24 04:39:23','2026-05-24 04:39:23','2026-05-24 04:39:23','',25.4586876,68.7827225,0,0,0,NULL,'{\"distance\":0.12378089085833159,\"totalDistance\":492.98663039244065,\"motion\":false}',0,'null','[1]'),(276,'osmand',3,'2026-05-24 04:39:24','2026-05-24 04:39:24','2026-05-24 04:39:24','',25.4586874,68.7827227,0,0,0,NULL,'{\"distance\":0.029996173598048997,\"totalDistance\":493.01662656603867,\"motion\":false}',0,'null','[1]'),(277,'osmand',3,'2026-05-24 04:39:26','2026-05-24 04:39:26','2026-05-24 04:39:26','',25.458687,68.7827221,0,0,0,NULL,'{\"distance\":0.07496351314430579,\"totalDistance\":493.091590079183,\"motion\":false}',0,'null','[1]'),(278,'osmand',3,'2026-05-24 04:39:28','2026-05-24 04:39:28','2026-05-24 04:39:28','',25.4586876,68.7827221,0,0,0,NULL,'{\"distance\":0.06679169446552584,\"totalDistance\":493.1583817736485,\"motion\":false}',0,'null','[1]'),(279,'osmand',3,'2026-05-24 04:39:30','2026-05-24 04:39:30','2026-05-24 04:39:30','',25.4586875,68.7827221,0,0,0,NULL,'{\"distance\":0.011131949209416398,\"totalDistance\":493.1695137228579,\"motion\":false}',0,'null','[1]'),(280,'osmand',3,'2026-05-24 04:39:32','2026-05-24 04:39:32','2026-05-24 04:39:32','',25.4586869,68.7827217,0,0,0,NULL,'{\"distance\":0.07795824342693722,\"totalDistance\":493.2474719662849,\"motion\":false}',0,'null','[1]'),(281,'osmand',3,'2026-05-24 04:39:34','2026-05-24 04:39:34','2026-05-24 04:39:34','',25.4586871,68.7827228,0,0,0,NULL,'{\"distance\":0.11278024154068637,\"totalDistance\":493.36025220782557,\"motion\":false}',0,'null','[1]'),(282,'osmand',3,'2026-05-24 04:39:36','2026-05-24 04:39:36','2026-05-24 04:39:36','',25.4586868,68.7827227,0,0,0,NULL,'{\"distance\":0.034875563887337084,\"totalDistance\":493.3951277717129,\"motion\":false}',0,'null','[1]'),(283,'osmand',3,'2026-05-24 04:39:38','2026-05-24 04:39:38','2026-05-24 04:39:38','',25.4586866,68.7827225,0,0,0,NULL,'{\"distance\":0.029996173394059956,\"totalDistance\":493.425123945107,\"motion\":false}',0,'null','[1]'),(284,'osmand',3,'2026-05-24 04:39:40','2026-05-24 04:39:40','2026-05-24 04:39:40','',25.458687,68.782723,0,0,0,NULL,'{\"distance\":0.06714374753653597,\"totalDistance\":493.4922676926435,\"motion\":false}',0,'null','[1]'),(285,'osmand',3,'2026-05-24 04:39:42','2026-05-24 04:39:42','2026-05-24 04:39:42','',25.4586887,68.7827249,0,0,0,NULL,'{\"distance\":0.26885316345240934,\"totalDistance\":493.76112085609594,\"motion\":false}',0,'null','[1]'),(286,'osmand',3,'2026-05-24 04:39:44','2026-05-24 04:39:44','2026-05-24 04:39:44','',25.4586906,68.7827274,0,0,0,NULL,'{\"distance\":0.328442044024013,\"totalDistance\":494.08956290012,\"motion\":false}',0,'null','[1]'),(287,'osmand',3,'2026-05-24 04:39:46','2026-05-24 04:39:46','2026-05-24 04:39:46','',25.4586923,68.7827298,0,0,0,NULL,'{\"distance\":0.3065971624459191,\"totalDistance\":494.3961600625659,\"motion\":false}',0,'null','[1]'),(288,'osmand',3,'2026-05-24 04:39:48','2026-05-24 04:39:48','2026-05-24 04:39:48','',25.4586921,68.7827315,0,0,0,NULL,'{\"distance\":0.17231114636564296,\"totalDistance\":494.56847120893156,\"motion\":false}',0,'null','[1]'),(289,'osmand',3,'2026-05-24 04:39:49','2026-05-24 04:39:49','2026-05-24 04:39:49','',25.458692,68.7827323,0,0,0,NULL,'{\"distance\":0.08117480425989716,\"totalDistance\":494.64964601319144,\"motion\":false}',0,'null','[1]'),(290,'osmand',3,'2026-05-24 04:39:51','2026-05-24 04:39:51','2026-05-24 04:39:51','',25.4586927,68.7827342,0,0,0,NULL,'{\"distance\":0.20625506207636715,\"totalDistance\":494.8559010752678,\"motion\":false}',0,'null','[1]'),(291,'osmand',3,'2026-05-24 04:39:53','2026-05-24 04:39:53','2026-05-24 04:39:53','',25.4586925,68.7827348,0,0,0,NULL,'{\"distance\":0.06428440466596709,\"totalDistance\":494.92018547993376,\"motion\":false}',0,'null','[1]'),(292,'osmand',3,'2026-05-24 04:39:55','2026-05-24 04:39:55','2026-05-24 04:39:55','',25.4586926,68.7827356,0,0,0,NULL,'{\"distance\":0.0811748024599128,\"totalDistance\":495.0013602823937,\"motion\":false}',0,'null','[1]'),(293,'osmand',3,'2026-05-24 04:39:57','2026-05-24 04:39:57','2026-05-24 04:39:57','',25.4586931,68.7827368,0,0,0,NULL,'{\"distance\":0.1328353153091055,\"totalDistance\":495.1341955977028,\"motion\":false}',0,'null','[1]'),(294,'osmand',3,'2026-05-24 04:39:58','2026-05-24 04:39:58','2026-05-24 04:39:58','',25.4586932,68.7827371,0,0,0,NULL,'{\"distance\":0.03214220280519004,\"totalDistance\":495.16633780050796,\"motion\":false}',0,'null','[1]'),(295,'osmand',3,'2026-05-24 04:40:00','2026-05-24 04:40:00','2026-05-24 04:40:00','',25.4586923,68.7827371,0,0,0,NULL,'{\"distance\":0.10018754169828878,\"totalDistance\":495.26652534220625,\"motion\":false}',0,'null','[1]'),(296,'osmand',3,'2026-05-24 04:40:02','2026-05-24 04:40:02','2026-05-24 04:40:02','',25.4586921,68.7827377,0,0,0,NULL,'{\"distance\":0.06428440351407003,\"totalDistance\":495.33080974572033,\"motion\":false}',0,'null','[1]'),(297,'osmand',3,'2026-05-24 04:40:04','2026-05-24 04:40:04','2026-05-24 04:40:04','',25.4586924,68.7827388,0,0,0,NULL,'{\"distance\":0.11549451620176494,\"totalDistance\":495.4463042619221,\"motion\":false}',0,'null','[1]'),(298,'osmand',3,'2026-05-24 04:40:06','2026-05-24 04:40:06','2026-05-24 04:40:06','',25.458692,68.7827395,0,0,0,NULL,'{\"distance\":0.08326354712228304,\"totalDistance\":495.52956780904435,\"motion\":false}',0,'null','[1]'),(299,'osmand',3,'2026-05-24 04:40:08','2026-05-24 04:40:08','2026-05-24 04:40:08','',25.4586929,68.7827402,0,0,0,NULL,'{\"distance\":0.12242400546612092,\"totalDistance\":495.6519918145105,\"motion\":false}',0,'null','[1]'),(300,'osmand',3,'2026-05-24 04:40:10','2026-05-24 04:40:10','2026-05-24 04:40:10','',25.4586926,68.7827413,0,0,0,NULL,'{\"distance\":0.1154945143947267,\"totalDistance\":495.76748632890525,\"motion\":false}',0,'null','[1]'),(301,'osmand',3,'2026-05-24 04:40:12','2026-05-24 04:40:12','2026-05-24 04:40:12','',25.4586924,68.7827421,0,0,0,NULL,'{\"distance\":0.08343326333409375,\"totalDistance\":495.85091959223934,\"motion\":false}',0,'null','[1]'),(302,'osmand',3,'2026-05-24 04:40:14','2026-05-24 04:40:14','2026-05-24 04:40:14','',25.4586933,68.782743,0,0,0,NULL,'{\"distance\":0.1349827814444785,\"totalDistance\":495.9859023736838,\"motion\":false}',0,'null','[1]'),(303,'osmand',3,'2026-05-24 04:40:16','2026-05-24 04:40:16','2026-05-24 04:40:16','',25.4586933,68.7827431,0,0,0,NULL,'{\"distance\":0.010050986688128117,\"totalDistance\":495.9959533603719,\"motion\":false}',0,'null','[1]'),(304,'osmand',3,'2026-05-24 04:40:18','2026-05-24 04:40:18','2026-05-24 04:40:18','',25.4586929,68.7827437,0,0,0,NULL,'{\"distance\":0.07496351100079886,\"totalDistance\":496.07091687137273,\"motion\":false}',0,'null','[1]'),(305,'osmand',3,'2026-05-24 04:40:20','2026-05-24 04:40:20','2026-05-24 04:40:20','',25.4586941,68.7827439,0,0,0,NULL,'{\"distance\":0.13508742011437153,\"totalDistance\":496.2060042914871,\"motion\":false}',0,'null','[1]'),(306,'osmand',3,'2026-05-24 04:40:21','2026-05-24 04:40:21','2026-05-24 04:40:21','',25.4586943,68.7827443,0,0,0,NULL,'{\"distance\":0.045956917361907657,\"totalDistance\":496.251961208849,\"motion\":false}',0,'null','[1]'),(307,'osmand',3,'2026-05-24 04:40:23','2026-05-24 04:40:23','2026-05-24 04:40:23','',25.4586939,68.7827446,0,0,0,NULL,'{\"distance\":0.05377662570558977,\"totalDistance\":496.30573783455463,\"motion\":false}',0,'null','[1]'),(308,'osmand',3,'2026-05-24 04:40:25','2026-05-24 04:40:25','2026-05-24 04:40:25','',25.4586939,68.7827455,0,0,0,NULL,'{\"distance\":0.09045887260050521,\"totalDistance\":496.3961967071551,\"motion\":false}',0,'null','[1]'),(309,'osmand',3,'2026-05-24 04:40:27','2026-05-24 04:40:27','2026-05-24 04:40:27','',25.458694,68.7827458,0,0,0,NULL,'{\"distance\":0.032142201414191114,\"totalDistance\":496.42833890856934,\"motion\":false}',0,'null','[1]'),(310,'osmand',3,'2026-05-24 04:40:29','2026-05-24 04:40:29','2026-05-24 04:40:29','',25.4586939,68.7827459,0,0,0,NULL,'{\"distance\":0.014998086438023561,\"totalDistance\":496.44333699500737,\"motion\":false}',0,'null','[1]'),(311,'osmand',3,'2026-05-24 04:40:30','2026-05-24 04:40:30','2026-05-24 04:40:30','',25.458694,68.7827459,0,0,0,NULL,'{\"distance\":0.011131949209416398,\"totalDistance\":496.4544689442168,\"motion\":false}',0,'null','[1]'),(312,'osmand',3,'2026-05-24 04:40:32','2026-05-24 04:40:32','2026-05-24 04:40:32','',25.4586946,68.7827461,0,0,0,NULL,'{\"distance\":0.06975112700921675,\"totalDistance\":496.524220071226,\"motion\":false}',0,'null','[1]'),(313,'osmand',3,'2026-05-24 04:40:34','2026-05-24 04:40:34','2026-05-24 04:40:34','',25.4586946,68.7827458,0,0,0,NULL,'{\"distance\":0.030152956882005293,\"totalDistance\":496.554373028108,\"motion\":false}',0,'null','[1]'),(314,'osmand',3,'2026-05-24 04:40:36','2026-05-24 04:40:36','2026-05-24 04:40:36','',25.4586946,68.7827455,0,0,0,NULL,'{\"distance\":0.030152956882005293,\"totalDistance\":496.58452598498997,\"motion\":false}',0,'null','[1]'),(315,'osmand',3,'2026-05-24 04:40:38','2026-05-24 04:40:38','2026-05-24 04:40:38','',25.4586949,68.7827448,0,0,0,NULL,'{\"distance\":0.0778805240481145,\"totalDistance\":496.6624065090381,\"motion\":false}',0,'null','[1]'),(316,'osmand',3,'2026-05-24 04:40:40','2026-05-24 04:40:40','2026-05-24 04:40:40','',25.4586944,68.782745,0,0,0,NULL,'{\"distance\":0.05917851428626487,\"totalDistance\":496.72158502332434,\"motion\":false}',0,'null','[1]'),(317,'osmand',3,'2026-05-24 04:40:42','2026-05-24 04:40:42','2026-05-24 04:40:42','',25.4586942,68.7827442,0,0,0,NULL,'{\"distance\":0.08343326355159363,\"totalDistance\":496.8050182868759,\"motion\":false}',0,'null','[1]'),(318,'osmand',3,'2026-05-24 04:40:44','2026-05-24 04:40:44','2026-05-24 04:40:44','',25.4586939,68.7827439,0,0,0,NULL,'{\"distance\":0.044994259960937984,\"totalDistance\":496.85001254683687,\"motion\":false}',0,'null','[1]'),(319,'osmand',3,'2026-05-24 04:40:46','2026-05-24 04:40:46','2026-05-24 04:40:46','',25.4586938,68.7827438,0,0,0,NULL,'{\"distance\":0.014998086443620474,\"totalDistance\":496.86501063328046,\"motion\":false}',0,'null','[1]'),(320,'osmand',3,'2026-05-24 04:40:48','2026-05-24 04:40:48','2026-05-24 04:40:48','',25.4586937,68.7827437,0,0,0,NULL,'{\"distance\":0.01499808711287548,\"totalDistance\":496.88000872039333,\"motion\":false}',0,'null','[1]'),(321,'osmand',3,'2026-05-24 04:40:50','2026-05-24 04:40:50','2026-05-24 04:40:50','',25.4586935,68.782744,0,0,0,NULL,'{\"distance\":0.03748175551707681,\"totalDistance\":496.9174904759104,\"motion\":false}',0,'null','[1]'),(322,'osmand',3,'2026-05-24 04:40:52','2026-05-24 04:40:52','2026-05-24 04:40:52','',25.4586928,68.7827436,0,0,0,NULL,'{\"distance\":0.08768381364827137,\"totalDistance\":497.0051742895587,\"motion\":false}',0,'null','[1]'),(323,'osmand',3,'2026-05-24 04:40:54','2026-05-24 04:40:54','2026-05-24 04:40:54','',25.4586935,68.7827435,0,0,0,NULL,'{\"distance\":0.07856918298926531,\"totalDistance\":497.08374347254795,\"motion\":false}',0,'null','[1]'),(324,'osmand',3,'2026-05-24 04:40:55','2026-05-24 04:40:55','2026-05-24 04:40:55','',25.4586931,68.7827438,0,0,0,NULL,'{\"distance\":0.05377662629138646,\"totalDistance\":497.13752009883933,\"motion\":false}',0,'null','[1]'),(325,'osmand',3,'2026-05-24 04:40:57','2026-05-24 04:40:57','2026-05-24 04:40:57','',25.4586929,68.7827439,0,0,0,NULL,'{\"distance\":0.024427514773312953,\"totalDistance\":497.16194761361265,\"motion\":false}',0,'null','[1]'),(326,'osmand',3,'2026-05-24 04:40:59','2026-05-24 04:40:59','2026-05-24 04:40:59','',25.4586923,68.7827438,0,0,0,NULL,'{\"distance\":0.06754370996209799,\"totalDistance\":497.22949132357473,\"motion\":false}',0,'null','[1]'),(327,'osmand',3,'2026-05-24 04:41:01','2026-05-24 04:41:01','2026-05-24 04:41:01','',25.4586926,68.782744,0,0,0,NULL,'{\"distance\":0.03897912052461931,\"totalDistance\":497.26847044409936,\"motion\":false}',0,'null','[1]'),(328,'osmand',3,'2026-05-24 04:41:03','2026-05-24 04:41:03','2026-05-24 04:41:03','',25.4586919,68.782744,0,0,0,NULL,'{\"distance\":0.07792364327945596,\"totalDistance\":497.3463940873788,\"motion\":false}',0,'null','[1]'),(329,'osmand',3,'2026-05-24 04:41:05','2026-05-24 04:41:05','2026-05-24 04:41:05','',25.4586925,68.7827439,0,0,0,NULL,'{\"distance\":0.06754370996706917,\"totalDistance\":497.4139377973459,\"motion\":false}',0,'null','[1]'),(330,'osmand',3,'2026-05-24 04:41:07','2026-05-24 04:41:07','2026-05-24 04:41:07','',25.4586923,68.782744,0,0,0,NULL,'{\"distance\":0.02442751479393142,\"totalDistance\":497.43836531213987,\"motion\":false}',0,'null','[1]'),(331,'osmand',3,'2026-05-24 04:41:09','2026-05-24 04:41:08','2026-05-24 04:41:08','',25.458692,68.7827438,0,0,0,NULL,'{\"distance\":0.038979120550461765,\"totalDistance\":497.4773444326903,\"motion\":false}',0,'null','[1]'),(332,'osmand',3,'2026-05-24 04:41:10','2026-05-24 04:41:09','2026-05-24 04:41:09','',25.4586915,68.7827436,0,0,0,NULL,'{\"distance\":0.059178514078836945,\"totalDistance\":497.53652294676914,\"motion\":false}',0,'null','[1]'),(333,'osmand',3,'2026-05-24 04:41:11','2026-05-24 04:41:11','2026-05-24 04:41:11','',25.458692,68.7827433,0,0,0,NULL,'{\"distance\":0.06330251253912306,\"totalDistance\":497.59982545930825,\"motion\":false}',0,'null','[1]'),(334,'osmand',3,'2026-05-24 04:41:13','2026-05-24 04:41:13','2026-05-24 04:41:13','',25.4586917,68.7827436,0,0,0,NULL,'{\"distance\":0.044994260330334344,\"totalDistance\":497.6448197196386,\"motion\":false}',0,'null','[1]'),(335,'osmand',3,'2026-05-24 04:41:15','2026-05-24 04:41:15','2026-05-24 04:41:15','',25.4586914,68.7827432,0,0,0,NULL,'{\"distance\":0.052265091257768015,\"totalDistance\":497.69708481089634,\"motion\":false}',0,'null','[1]'),(336,'osmand',3,'2026-05-24 04:41:17','2026-05-24 04:41:17','2026-05-24 04:41:17','',25.4586919,68.7827429,0,0,0,NULL,'{\"distance\":0.06330251289879524,\"totalDistance\":497.76038732379516,\"motion\":false}',0,'null','[1]'),(337,'osmand',3,'2026-05-24 04:41:19','2026-05-24 04:41:19','2026-05-24 04:41:19','',25.458692,68.7827437,0,0,0,NULL,'{\"distance\":0.08117480285700789,\"totalDistance\":497.84156212665215,\"motion\":false}',0,'null','[1]'),(338,'osmand',3,'2026-05-24 04:41:21','2026-05-24 04:41:21','2026-05-24 04:41:21','',25.4586918,68.7827435,0,0,0,NULL,'{\"distance\":0.029996173769178687,\"totalDistance\":497.8715583004213,\"motion\":false}',0,'null','[1]'),(339,'osmand',3,'2026-05-24 04:41:23','2026-05-24 04:41:23','2026-05-24 04:41:23','',25.4586926,68.7827435,0,0,0,NULL,'{\"distance\":0.08905559248887235,\"totalDistance\":497.9606138929102,\"motion\":false}',0,'null','[1]'),(340,'osmand',3,'2026-05-24 04:41:25','2026-05-24 04:41:25','2026-05-24 04:41:25','',25.4586928,68.7827432,0,0,0,NULL,'{\"distance\":0.03748175569848198,\"totalDistance\":497.9980956486087,\"motion\":false}',0,'null','[1]'),(341,'osmand',3,'2026-05-24 04:41:27','2026-05-24 04:41:27','2026-05-24 04:41:27','',25.4586936,68.7827433,0,0,0,NULL,'{\"distance\":0.08962098463594848,\"totalDistance\":498.0877166332446,\"motion\":false}',0,'null','[1]'),(342,'osmand',3,'2026-05-24 04:41:29','2026-05-24 04:41:29','2026-05-24 04:41:29','',25.4586939,68.7827432,0,0,0,NULL,'{\"distance\":0.03487556372366588,\"totalDistance\":498.1225921969683,\"motion\":false}',0,'null','[1]'),(343,'osmand',3,'2026-05-24 04:41:31','2026-05-24 04:41:31','2026-05-24 04:41:31','',25.4586937,68.7827431,0,0,0,NULL,'{\"distance\":0.024427514385364755,\"totalDistance\":498.14701971135366,\"motion\":false}',0,'null','[1]'),(344,'osmand',3,'2026-05-24 04:41:33','2026-05-24 04:41:33','2026-05-24 04:41:33','',25.4586934,68.7827435,0,0,0,NULL,'{\"distance\":0.052265089645098795,\"totalDistance\":498.1992848009988,\"motion\":false}',0,'null','[1]'),(345,'osmand',3,'2026-05-24 04:41:35','2026-05-24 04:41:35','2026-05-24 04:41:35','',25.4586939,68.7827433,0,0,0,NULL,'{\"distance\":0.05917851348585252,\"totalDistance\":498.25846331448463,\"motion\":false}',0,'null','[1]'),(346,'osmand',3,'2026-05-24 04:41:37','2026-05-24 04:41:37','2026-05-24 04:41:37','',25.4586933,68.782743,0,0,0,NULL,'{\"distance\":0.07328254471257652,\"totalDistance\":498.3317458591972,\"motion\":false}',0,'null','[1]'),(347,'osmand',3,'2026-05-24 04:41:39','2026-05-24 04:41:39','2026-05-24 04:41:39','',25.4586938,68.7827428,0,0,0,NULL,'{\"distance\":0.05917851397670704,\"totalDistance\":498.3909243731739,\"motion\":false}',0,'null','[1]'),(348,'osmand',3,'2026-05-24 04:41:41','2026-05-24 04:41:41','2026-05-24 04:41:41','',25.4586937,68.7827428,0,0,0,NULL,'{\"distance\":0.01113194881393012,\"totalDistance\":498.40205632198786,\"motion\":false}',0,'null','[1]'),(349,'osmand',3,'2026-05-24 04:41:43','2026-05-24 04:41:43','2026-05-24 04:41:43','',25.4586931,68.7827432,0,0,0,NULL,'{\"distance\":0.0779582423587825,\"totalDistance\":498.4800145643466,\"motion\":false}',0,'null','[1]'),(350,'osmand',3,'2026-05-24 04:41:45','2026-05-24 04:41:45','2026-05-24 04:41:45','',25.4586934,68.7827438,0,0,0,NULL,'{\"distance\":0.068935376267723,\"totalDistance\":498.54894994061436,\"motion\":false}',0,'null','[1]'),(351,'osmand',3,'2026-05-24 04:41:47','2026-05-24 04:41:47','2026-05-24 04:41:47','',25.4586931,68.7827435,0,0,0,NULL,'{\"distance\":0.04499426105246169,\"totalDistance\":498.59394420166683,\"motion\":false}',0,'null','[1]'),(352,'osmand',3,'2026-05-24 04:41:49','2026-05-24 04:41:49','2026-05-24 04:41:49','',25.4586922,68.7827434,0,0,0,NULL,'{\"distance\":0.1006904455116287,\"totalDistance\":498.6946346471785,\"motion\":false}',0,'null','[1]'),(353,'osmand',3,'2026-05-24 04:41:51','2026-05-24 04:41:51','2026-05-24 04:41:51','',25.4586932,68.7827433,0,0,0,NULL,'{\"distance\":0.11177231890588997,\"totalDistance\":498.80640696608435,\"motion\":false}',0,'null','[1]'),(354,'osmand',3,'2026-05-24 04:41:53','2026-05-24 04:41:53','2026-05-24 04:41:53','',25.4586929,68.7827428,0,0,0,NULL,'{\"distance\":0.06033937910591575,\"totalDistance\":498.8667463451903,\"motion\":false}',0,'null','[1]'),(355,'osmand',3,'2026-05-24 04:41:55','2026-05-24 04:41:55','2026-05-24 04:41:55','',25.4586924,68.7827424,0,0,0,NULL,'{\"distance\":0.06866122813762333,\"totalDistance\":498.9354075733279,\"motion\":false}',0,'null','[1]'),(356,'osmand',3,'2026-05-24 04:41:57','2026-05-24 04:41:56','2026-05-24 04:41:56','',25.4586928,68.7827425,0,0,0,NULL,'{\"distance\":0.045648077307418086,\"totalDistance\":498.9810556506353,\"motion\":false}',0,'null','[1]'),(357,'osmand',3,'2026-05-24 04:41:58','2026-05-24 04:41:57','2026-05-24 04:41:57','',25.4586928,68.7827428,0,0,0,NULL,'{\"distance\":0.03015295733299814,\"totalDistance\":499.0112086079683,\"motion\":false}',0,'null','[1]'),(358,'osmand',3,'2026-05-24 04:41:59','2026-05-24 04:41:59','2026-05-24 04:41:59','',25.4586924,68.7827428,0,0,0,NULL,'{\"distance\":0.044527796442179315,\"totalDistance\":499.0557364044105,\"motion\":false}',0,'null','[1]'),(359,'osmand',3,'2026-05-24 04:42:01','2026-05-24 04:42:01','2026-05-24 04:42:01','',25.4586922,68.7827429,0,0,0,NULL,'{\"distance\":0.024427515024614398,\"totalDistance\":499.0801639194351,\"motion\":false}',0,'null','[1]'),(360,'osmand',3,'2026-05-24 04:42:02','2026-05-24 04:42:02','2026-05-24 04:42:02','',25.4586931,68.7827434,0,0,0,NULL,'{\"distance\":0.11208524186201763,\"totalDistance\":499.1922491612971,\"motion\":false}',0,'null','[1]'),(361,'osmand',3,'2026-05-24 04:42:04','2026-05-24 04:42:04','2026-05-24 04:42:04','',25.458693,68.7827436,0,0,0,NULL,'{\"distance\":0.02297845884899724,\"totalDistance\":499.21522762014615,\"motion\":false}',0,'null','[1]'),(362,'osmand',3,'2026-05-24 04:42:06','2026-05-24 04:42:06','2026-05-24 04:42:06','',25.4586928,68.782743,0,0,0,NULL,'{\"distance\":0.06428440452493996,\"totalDistance\":499.2795120246711,\"motion\":false}',0,'null','[1]'),(363,'osmand',3,'2026-05-24 04:42:08','2026-05-24 04:42:08','2026-05-24 04:42:08','',25.4586939,68.7827432,0,0,0,NULL,'{\"distance\":0.12409046847264572,\"totalDistance\":499.40360249314375,\"motion\":false}',0,'null','[1]'),(364,'osmand',3,'2026-05-24 04:42:10','2026-05-24 04:42:10','2026-05-24 04:42:10','',25.4586936,68.7827429,0,0,0,NULL,'{\"distance\":0.044994260011310225,\"totalDistance\":499.4485967531551,\"motion\":false}',0,'null','[1]'),(365,'osmand',3,'2026-05-24 04:42:12','2026-05-24 04:42:12','2026-05-24 04:42:12','',25.4586931,68.782743,0,0,0,NULL,'{\"distance\":0.05655996416710068,\"totalDistance\":499.50515671732217,\"motion\":false}',0,'null','[1]'),(366,'osmand',3,'2026-05-24 04:42:14','2026-05-24 04:42:14','2026-05-24 04:42:14','',25.4586936,68.7827433,0,0,0,NULL,'{\"distance\":0.06330251302852877,\"totalDistance\":499.5684592303507,\"motion\":false}',0,'null','[1]'),(367,'osmand',3,'2026-05-24 04:42:16','2026-05-24 04:42:16','2026-05-24 04:42:16','',25.4586932,68.7827438,0,0,0,NULL,'{\"distance\":0.0671437454737086,\"totalDistance\":499.6356029758244,\"motion\":false}',0,'null','[1]'),(368,'osmand',3,'2026-05-24 04:42:18','2026-05-24 04:42:18','2026-05-24 04:42:18','',25.4586926,68.7827443,0,0,0,NULL,'{\"distance\":0.08358641259680855,\"totalDistance\":499.71918938842117,\"motion\":false}',0,'null','[1]'),(369,'osmand',3,'2026-05-24 04:42:20','2026-05-24 04:42:20','2026-05-24 04:42:20','',25.4586929,68.7827443,0,0,0,NULL,'{\"distance\":0.03339584723276292,\"totalDistance\":499.75258523565395,\"motion\":false}',0,'null','[1]'),(370,'osmand',3,'2026-05-24 04:42:22','2026-05-24 04:42:22','2026-05-24 04:42:22','',25.4586921,68.7827449,0,0,0,NULL,'{\"distance\":0.10755325153326709,\"totalDistance\":499.8601384871872,\"motion\":false}',0,'null','[1]'),(371,'osmand',3,'2026-05-24 04:42:24','2026-05-24 04:42:24','2026-05-24 04:42:24','',25.4586923,68.7827453,0,0,0,NULL,'{\"distance\":0.045956917754812567,\"totalDistance\":499.90609540494205,\"motion\":false}',0,'null','[1]'),(372,'osmand',3,'2026-05-24 04:42:26','2026-05-24 04:42:26','2026-05-24 04:42:26','',25.4586923,68.7827458,0,0,0,NULL,'{\"distance\":0.05025492957323355,\"totalDistance\":499.95635033451526,\"motion\":false}',0,'null','[1]'),(373,'osmand',3,'2026-05-24 04:42:28','2026-05-24 04:42:28','2026-05-24 04:42:28','',25.4586921,68.7827457,0,0,0,NULL,'{\"distance\":0.024427514440347343,\"totalDistance\":499.9807778489556,\"motion\":false}',0,'null','[1]'),(374,'osmand',3,'2026-05-24 04:42:30','2026-05-24 04:42:30','2026-05-24 04:42:30','',25.4586913,68.7827458,0,0,0,NULL,'{\"distance\":0.08962098448981093,\"totalDistance\":500.0703988334454,\"motion\":false}',0,'null','[1]'),(375,'osmand',3,'2026-05-24 04:42:31','2026-05-24 04:42:30','2026-05-24 04:42:30','',25.4586912,68.7827456,0,0,0,NULL,'{\"distance\":0.02297845911202171,\"totalDistance\":500.0933772925574,\"motion\":false}',0,'null','[1]'),(376,'osmand',3,'2026-05-24 05:16:21','2026-05-24 05:16:21','2026-05-24 04:42:30','',25.4586912,68.7827456,0,0,0,NULL,'{\"notificationToken\":\"chJhC0tsRpuwNNApEBJE-P:APA91bFfCqUbSvJddmKVPVfZVFUP6lPhT8ZxhWlD3Y81uGZ6VzYWZL0UzV2iNStkCdvq6San8bfTMHjTJ8adeaw2s42LmQNRlVqJ6KlA4NLsM6natTLCXWY\",\"distance\":0.0,\"totalDistance\":500.0933772925574,\"motion\":false}',0,'null','[1]'),(377,'osmand',3,'2026-05-24 05:16:23','2026-05-24 05:16:21','2026-05-24 05:16:21','',25.4587664,68.7827597,0,0,0,NULL,'{\"distance\":8.490338234593258,\"totalDistance\":508.5837155271507,\"motion\":false}',0,'null','[1]'),(378,'osmand',3,'2026-05-24 05:16:27','2026-05-24 05:16:26','2026-05-24 05:16:26','',25.4587115,68.7827159,0,0,0,NULL,'{\"distance\":7.531945966087565,\"totalDistance\":516.1156614932382,\"motion\":false}',0,'null','[1]'),(379,'osmand',4,'2026-05-24 06:07:05','2026-05-24 06:02:52','2026-05-24 06:02:52','',25.4587704,68.7827658,0,0,0,NULL,'{\"distance\":0.0,\"totalDistance\":0.0,\"motion\":false}',0,'null','null'),(380,'osmand',4,'2026-05-24 06:07:05','2026-05-24 06:03:05','2026-05-24 06:03:05','',25.4587602,68.7826958,0,0,0,NULL,'{\"distance\":7.126720329714412,\"totalDistance\":7.126720329714412,\"motion\":false}',0,'null','null'),(381,'osmand',4,'2026-05-24 06:07:06','2026-05-24 06:07:03','2026-05-24 06:07:03','',25.4587719,68.782748,0,0,0,NULL,'{\"distance\":5.40585576132318,\"totalDistance\":12.532576091037592,\"motion\":false}',0,'null','null'),(382,'osmand',3,'2026-05-24 06:12:29','2026-05-24 06:12:29','2026-05-24 06:12:29','',25.4587616,68.7827117,0,0,0,NULL,'{\"distance\":5.593059987607764,\"totalDistance\":521.708721480846,\"motion\":false}',0,'null','[1]'),(383,'osmand',3,'2026-05-24 06:17:27','2026-05-24 06:17:27','2026-05-24 06:12:29','',25.4587616,68.7827117,0,0,0,NULL,'{\"notificationToken\":\"chJhC0tsRpuwNNApEBJE-P:APA91bFfCqUbSvJddmKVPVfZVFUP6lPhT8ZxhWlD3Y81uGZ6VzYWZL0UzV2iNStkCdvq6San8bfTMHjTJ8adeaw2s42LmQNRlVqJ6KlA4NLsM6natTLCXWY\",\"distance\":0.0,\"totalDistance\":521.708721480846,\"motion\":false}',0,'null','[1]'),(384,'osmand',3,'2026-05-24 06:17:27','2026-05-24 06:17:23','2026-05-24 06:17:23','',25.4587236,68.7826881,0,0,0,NULL,'{\"distance\":4.849806620512579,\"totalDistance\":526.5585281013585,\"motion\":false}',0,'null','[1]'),(385,'osmand',4,'2026-05-24 06:43:08','2026-05-24 06:43:03','2026-05-24 06:43:03','',25.4654403,68.7198772,0,0,0,NULL,'{\"distance\":6362.408935391107,\"totalDistance\":6374.941511482144,\"motion\":false}',0,'null','null'),(386,'osmand',4,'2026-05-24 06:47:07','2026-05-24 06:47:04','2026-05-24 06:47:04','',25.4628896,68.7182874,0,0,0,NULL,'{\"distance\":325.81301340324404,\"totalDistance\":6700.7545248853885,\"motion\":false}',0,'null','null'),(387,'osmand',4,'2026-05-24 06:52:06','2026-05-24 06:51:46','2026-05-24 06:51:46','',25.4629011,68.7182762,0,0,0,NULL,'{\"distance\":1.7046938957583093,\"totalDistance\":6702.459218781147,\"motion\":false}',0,'null','null'),(388,'osmand',4,'2026-05-24 06:57:07','2026-05-24 06:57:05','2026-05-24 06:57:05','',25.4628916,68.7182745,0,0,0,NULL,'{\"distance\":1.0712488180994055,\"totalDistance\":6703.530467599247,\"motion\":false}',0,'null','null'),(389,'osmand',4,'2026-05-24 07:02:07','2026-05-24 06:57:05','2026-05-24 06:57:05','',25.4628916,68.7182745,0,0,0,NULL,'{\"distance\":0.0,\"totalDistance\":6703.530467599247,\"motion\":false}',0,'null','null'),(390,'osmand',4,'2026-05-24 07:02:08','2026-05-24 07:02:06','2026-05-24 07:02:06','',25.4628912,68.7182945,0,0,0,NULL,'{\"distance\":2.0106201658304728,\"totalDistance\":6705.5410877650775,\"motion\":false}',0,'null','null'),(391,'osmand',4,'2026-05-24 07:02:38','2026-05-24 07:02:35','2026-05-24 07:02:35','',25.4628848,68.7182955,0,0,0,NULL,'{\"distance\":0.7194991566789836,\"totalDistance\":6706.260586921757,\"motion\":false}',0,'null','null'),(392,'osmand',4,'2026-05-24 07:05:22','2026-05-24 07:05:21','2026-05-24 07:05:21','',25.4628127,68.718464,0,0,0,NULL,'{\"distance\":18.74097451952403,\"totalDistance\":6725.0015614412805,\"motion\":false}',0,'null','null'),(393,'osmand',4,'2026-05-24 07:06:17','2026-05-24 07:06:16','2026-05-24 07:06:16','',25.4628446,68.7184755,0,0,0,NULL,'{\"distance\":3.7344585922593847,\"totalDistance\":6728.73602003354,\"motion\":false}',0,'null','null'),(394,'osmand',4,'2026-05-24 07:06:49','2026-05-24 07:06:48','2026-05-24 07:06:48','',25.462849,68.7184662,0,0,0,NULL,'{\"distance\":1.0552683947511374,\"totalDistance\":6729.7912884282905,\"motion\":false}',0,'null','null'),(395,'osmand',4,'2026-05-24 07:12:07','2026-05-24 07:12:06','2026-05-24 07:12:06','',25.4628838,68.7184581,0,0,0,NULL,'{\"distance\":3.95853562405524,\"totalDistance\":6733.7498240523455,\"motion\":false}',0,'null','null'),(396,'osmand',4,'2026-05-24 07:12:27','2026-05-24 07:12:06','2026-05-24 07:12:06','',25.4628838,68.7184581,0,0,0,NULL,'{\"distance\":0.0,\"totalDistance\":6733.7498240523455,\"motion\":false}',0,'null','null'),(397,'osmand',4,'2026-05-24 08:05:59','2026-05-24 08:05:46','2026-05-24 08:05:46','',25.4604853,68.7197825,0,0,0,NULL,'{\"distance\":298.34155451600833,\"totalDistance\":7032.091378568354,\"motion\":false}',0,'null','null'),(398,'osmand',4,'2026-05-24 08:12:47','2026-05-24 08:12:41','2026-05-24 08:12:41','',25.4604628,68.7204426,0,0,0,NULL,'{\"distance\":66.39283774784515,\"totalDistance\":7098.484216316199,\"motion\":false}',0,'null','null'),(399,'osmand',4,'2026-05-24 08:43:33','2026-05-24 08:35:46','2026-05-24 08:35:46','',25.4607964,68.7203288,0,0,0,NULL,'{\"distance\":38.85769110696107,\"totalDistance\":7137.341907423161,\"motion\":false}',0,'null','null'),(400,'osmand',4,'2026-05-24 08:45:09','2026-05-24 08:35:46','2026-05-24 08:35:46','',25.4607964,68.7203288,0,0,0,NULL,'{\"distance\":0.0,\"totalDistance\":7137.341907423161,\"motion\":false}',0,'null','null'),(401,'osmand',4,'2026-05-24 08:45:10','2026-05-24 08:40:47','2026-05-24 08:40:47','',25.4609314,68.7202605,0,0,0,NULL,'{\"distance\":16.521768324930452,\"totalDistance\":7153.863675748091,\"motion\":false}',0,'null','null'),(402,'osmand',4,'2026-05-24 08:45:11','2026-05-24 08:42:38','2026-05-24 08:42:38','',25.4609344,68.7202621,0,0,0,NULL,'{\"distance\":0.37066023778147733,\"totalDistance\":7154.234335985872,\"motion\":false}',0,'null','null'),(403,'osmand',4,'2026-05-24 08:45:13','2026-05-24 08:45:07','2026-05-24 08:45:07','',25.4604457,68.7200057,0,0,0,NULL,'{\"distance\":60.19691052735095,\"totalDistance\":7214.431246513223,\"motion\":false}',0,'null','null'),(404,'osmand',4,'2026-05-24 08:50:51','2026-05-24 08:50:40','2026-05-24 08:50:40','',25.4635971,68.7222609,0,0,0,NULL,'{\"distance\":417.6668545289071,\"totalDistance\":7632.09810104213,\"motion\":false}',0,'null','null'),(405,'osmand',4,'2026-05-24 08:55:51','2026-05-24 08:55:40','2026-05-24 08:55:40','',25.4651934,68.7226245,0,0,0,NULL,'{\"distance\":181.41797294529746,\"totalDistance\":7813.516073987427,\"motion\":false}',0,'null','null'),(406,'osmand',4,'2026-05-24 08:57:05','2026-05-24 08:57:01','2026-05-24 08:57:01','',25.4651737,68.7226348,0,0,0,NULL,'{\"distance\":2.4250469469844727,\"totalDistance\":7815.941120934412,\"motion\":false}',0,'null','null'),(407,'osmand',4,'2026-05-24 08:58:34','2026-05-24 08:58:33','2026-05-24 08:58:33','',25.4651404,68.7226366,0,0,0,NULL,'{\"distance\":3.711350803648512,\"totalDistance\":7819.65247173806,\"motion\":false}',0,'null','null'),(408,'osmand',4,'2026-05-24 09:00:05','2026-05-24 09:00:04','2026-05-24 09:00:04','',25.4653256,68.7225578,0,0,0,NULL,'{\"distance\":22.085223174839097,\"totalDistance\":7841.737694912899,\"motion\":false}',0,'null','null'),(409,'osmand',4,'2026-05-24 09:00:39','2026-05-24 09:00:38','2026-05-24 09:00:38','',25.4652892,68.7226111,0,0,0,NULL,'{\"distance\":6.7167787544394475,\"totalDistance\":7848.454473667339,\"motion\":false}',0,'null','null'),(410,'osmand',4,'2026-05-24 09:01:34','2026-05-24 09:01:33','2026-05-24 09:01:33','',25.4652586,68.7226132,0,0,0,NULL,'{\"distance\":3.412908770235521,\"totalDistance\":7851.867382437575,\"motion\":false}',0,'null','null'),(411,'osmand',4,'2026-05-24 09:09:33','2026-05-24 09:06:17','2026-05-24 09:06:17','',25.4653431,68.722678,0,0,0,NULL,'{\"distance\":11.441031494607351,\"totalDistance\":7863.308413932182,\"motion\":false}',0,'null','null'),(412,'osmand',4,'2026-05-24 09:09:33','2026-05-24 09:07:47','2026-05-24 09:07:47','',25.4653258,68.7227391,0,0,0,NULL,'{\"distance\":6.435712850517245,\"totalDistance\":7869.744126782699,\"motion\":false}',0,'null','null'),(413,'osmand',4,'2026-05-24 09:09:33','2026-05-24 09:09:29','2026-05-24 09:09:29','',25.4653849,68.722688,0,0,0,NULL,'{\"distance\":8.346204553313534,\"totalDistance\":7878.090331336012,\"motion\":false}',0,'null','null'),(414,'osmand',4,'2026-05-24 09:10:16','2026-05-24 09:10:15','2026-05-24 09:10:15','',25.4653626,68.7226434,0,0,0,NULL,'{\"distance\":5.123978543100467,\"totalDistance\":7883.214309879113,\"motion\":false}',0,'null','null'),(415,'osmand',4,'2026-05-24 09:16:18','2026-05-24 09:16:11','2026-05-24 09:16:11','',25.4681698,68.7254543,0,0,0,NULL,'{\"distance\":421.26289114133124,\"totalDistance\":8304.477201020443,\"motion\":false}',0,'null','null'),(416,'osmand',4,'2026-05-24 09:27:40','2026-05-24 09:27:36','2026-05-24 09:27:36','',25.4781743,68.7716752,0,0,0,NULL,'{\"distance\":4776.739977749901,\"totalDistance\":13081.217178770345,\"motion\":false}',0,'null','null'),(417,'osmand',4,'2026-05-24 09:31:41','2026-05-24 09:31:33','2026-05-24 09:31:33','',25.4708166,68.7810651,0,0,0,NULL,'{\"distance\":1249.5334404981852,\"totalDistance\":14330.75061926853,\"motion\":false}',0,'null','null'),(418,'osmand',4,'2026-05-24 09:41:45','2026-05-24 09:41:44','2026-05-24 09:41:44','',25.4587785,68.7827248,0,0,0,NULL,'{\"distance\":1350.417070913181,\"totalDistance\":15681.167690181712,\"motion\":false}',0,'null','null'),(419,'osmand',4,'2026-05-24 09:43:56','2026-05-24 09:43:54','2026-05-24 09:43:54','',25.458748,68.782655,0,0,0,NULL,'{\"distance\":7.793978737361857,\"totalDistance\":15688.961668919073,\"motion\":false}',0,'null','null'),(420,'osmand',4,'2026-05-24 09:44:25','2026-05-24 09:44:24','2026-05-24 09:44:24','',25.4589518,68.7826588,0,0,0,NULL,'{\"distance\":22.690126973989763,\"totalDistance\":15711.651795893064,\"motion\":false}',0,'null','null'),(421,'osmand',4,'2026-05-24 09:45:24','2026-05-24 09:45:23','2026-05-24 09:45:23','',25.4591235,68.7826408,0,0,0,NULL,'{\"distance\":19.19898822983911,\"totalDistance\":15730.850784122902,\"motion\":false}',0,'null','null'),(422,'osmand',4,'2026-05-24 09:49:58','2026-05-24 09:49:21','2026-05-24 09:49:21','',25.4587879,68.7826507,0,0,0,NULL,'{\"distance\":37.372070188213655,\"totalDistance\":15768.222854311116,\"motion\":false}',0,'null','null'),(423,'osmand',4,'2026-05-24 09:51:54','2026-05-24 09:51:52','2026-05-24 09:51:52','',25.4590618,68.7827158,0,0,0,NULL,'{\"distance\":31.184582830401375,\"totalDistance\":15799.407437141517,\"motion\":false}',0,'null','null'),(424,'osmand',4,'2026-05-24 09:53:15','2026-05-24 09:53:14','2026-05-24 09:53:14','',25.459036,68.7826314,0,0,0,NULL,'{\"distance\":8.95600569030194,\"totalDistance\":15808.36344283182,\"motion\":false}',0,'null','null'),(425,'osmand',4,'2026-05-24 09:54:44','2026-05-24 09:54:43','2026-05-24 09:54:43','',25.4589493,68.782667,0,0,0,NULL,'{\"distance\":10.29332889483562,\"totalDistance\":15818.656771726655,\"motion\":false}',0,'null','null'),(426,'osmand',4,'2026-05-24 09:56:16','2026-05-24 09:56:15','2026-05-24 09:56:15','',25.4591107,68.7827263,0,0,0,NULL,'{\"distance\":18.929766464783253,\"totalDistance\":15837.58653819144,\"motion\":false}',0,'null','null'),(427,'osmand',4,'2026-05-24 09:57:45','2026-05-24 09:57:44','2026-05-24 09:57:44','',25.4590125,68.7826898,0,0,0,NULL,'{\"distance\":11.53073830189971,\"totalDistance\":15849.117276493338,\"motion\":false}',0,'null','null'),(428,'osmand',4,'2026-05-24 10:47:25','2026-05-24 10:47:23','2026-05-24 10:47:23','',25.4589343,68.7827008,0,0,0,NULL,'{\"distance\":8.77511230423334,\"totalDistance\":15857.89238879757,\"motion\":false}',0,'null','null'),(429,'osmand',4,'2026-05-24 10:50:42','2026-05-24 10:50:41','2026-05-24 10:50:41','',25.4587562,68.7826588,0,0,0,NULL,'{\"distance\":20.270437085139783,\"totalDistance\":15878.162825882711,\"motion\":false}',0,'null','null'),(430,'osmand',4,'2026-05-24 12:15:26','2026-05-24 12:15:25','2026-05-24 12:15:25','',25.4587781,68.7826304,0,0,0,NULL,'{\"distance\":3.753849625760506,\"totalDistance\":15881.916675508472,\"motion\":false}',0,'null','null'),(431,'osmand',4,'2026-05-24 12:19:33','2026-05-24 12:19:32','2026-05-24 12:19:32','',25.4587248,68.7827357,0,0,0,NULL,'{\"distance\":12.133372863817963,\"totalDistance\":15894.05004837229,\"motion\":false}',0,'null','null'),(432,'osmand',4,'2026-05-24 12:20:23','2026-05-24 12:20:22','2026-05-24 12:20:22','',25.4587164,68.7826741,0,0,0,NULL,'{\"distance\":6.2616202686834255,\"totalDistance\":15900.311668640974,\"motion\":false}',0,'null','null'),(433,'osmand',4,'2026-05-24 12:21:51','2026-05-24 12:21:50','2026-05-24 12:21:50','',25.4586158,68.7825611,0,0,0,NULL,'{\"distance\":15.950148883430947,\"totalDistance\":15916.261817524404,\"motion\":false}',0,'null','null'),(434,'osmand',4,'2026-05-24 12:23:21','2026-05-24 12:23:20','2026-05-24 12:23:20','',25.4587966,68.7826776,0,0,0,NULL,'{\"distance\":23.284942779071933,\"totalDistance\":15939.546760303476,\"motion\":false}',0,'null','null'),(435,'osmand',4,'2026-05-24 12:25:08','2026-05-24 12:25:07','2026-05-24 12:25:07','',25.4585633,68.7827253,0,0,0,NULL,'{\"distance\":26.409655369837584,\"totalDistance\":15965.956415673314,\"motion\":false}',0,'null','null'),(436,'osmand',4,'2026-05-24 12:27:31','2026-05-24 12:27:30','2026-05-24 12:27:30','',25.4587625,68.7826986,0,0,0,NULL,'{\"distance\":22.3366386545283,\"totalDistance\":15988.293054327842,\"motion\":false}',0,'null','null'),(437,'osmand',4,'2026-05-24 12:50:45','2026-05-24 12:50:44','2026-05-24 12:50:44','',25.4587508,68.7826493,0,0,0,NULL,'{\"distance\":5.123445330338172,\"totalDistance\":15993.41649965818,\"motion\":false}',0,'null','null'),(438,'osmand',4,'2026-05-24 12:54:22','2026-05-24 12:54:20','2026-05-24 12:54:20','',25.4587831,68.7828063,0,0,0,NULL,'{\"distance\":16.184501339112032,\"totalDistance\":16009.601000997292,\"motion\":false}',0,'null','null'),(439,'osmand',4,'2026-05-24 13:02:29','2026-05-24 13:00:35','2026-05-24 13:00:35','',25.4587447,68.7826595,0,0,0,NULL,'{\"distance\":15.361577130168182,\"totalDistance\":16024.96257812746,\"motion\":false}',0,'null','null'),(440,'osmand',4,'2026-05-24 13:02:30','2026-05-24 13:02:28','2026-05-24 13:02:28','',25.4589887,68.7824983,0,0,0,NULL,'{\"distance\":31.627235395275434,\"totalDistance\":16056.589813522736,\"motion\":false}',0,'null','null'),(441,'osmand',4,'2026-05-24 13:09:19','2026-05-24 13:09:17','2026-05-24 13:09:17','',25.4609217,68.7818764,0,0,0,NULL,'{\"distance\":224.07528511914313,\"totalDistance\":16280.665098641879,\"motion\":false}',0,'null','null'),(442,'osmand',4,'2026-05-24 13:24:48','2026-05-24 13:24:47','2026-05-24 13:24:47','',25.4637012,68.7170553,0,0,0,NULL,'{\"distance\":6522.306903126736,\"totalDistance\":22802.972001768616,\"motion\":false}',0,'null','null'),(443,'osmand',4,'2026-05-24 13:39:28','2026-05-24 13:31:30','2026-05-24 13:31:30','',25.4635942,68.7170826,0,0,0,NULL,'{\"distance\":12.223126140753086,\"totalDistance\":22815.19512790937,\"motion\":false}',0,'null','null'),(444,'osmand',4,'2026-05-24 13:39:28','2026-05-24 13:34:17','2026-05-24 13:34:17','',25.4633614,68.7172812,0,0,0,NULL,'{\"distance\":32.71110753372623,\"totalDistance\":22847.906235443097,\"motion\":false}',0,'null','null'),(445,'osmand',4,'2026-05-24 13:39:29','2026-05-24 13:39:26','2026-05-24 13:39:26','',25.4625864,68.718302,0,0,0,NULL,'{\"distance\":134.04875481113706,\"totalDistance\":22981.954990254235,\"motion\":false}',0,'null','null'),(446,'osmand',4,'2026-05-24 13:42:32','2026-05-24 13:42:31','2026-05-24 13:42:31','',25.4616548,68.7190032,0,0,0,NULL,'{\"distance\":125.38569774606337,\"totalDistance\":23107.3406880003,\"motion\":false}',0,'null','null'),(447,'osmand',4,'2026-05-24 13:52:12','2026-05-24 13:52:11','2026-05-24 13:52:11','',25.461677,68.718757,0,0,0,NULL,'{\"distance\":24.868014628763444,\"totalDistance\":23132.20870262906,\"motion\":false}',0,'null','null'),(448,'osmand',4,'2026-05-24 13:57:28','2026-05-24 13:57:27','2026-05-24 13:57:27','',25.4626022,68.7182817,0,0,0,NULL,'{\"distance\":113.5322893989647,\"totalDistance\":23245.740992028026,\"motion\":false}',0,'null','null'),(449,'osmand',4,'2026-05-24 14:02:33','2026-05-24 14:02:32','2026-05-24 14:02:32','',25.4625535,68.7183173,0,0,0,NULL,'{\"distance\":6.495566879288325,\"totalDistance\":23252.236558907316,\"motion\":false}',0,'null','null'),(450,'osmand',4,'2026-05-24 14:08:15','2026-05-24 14:02:38','2026-05-24 14:02:38','',25.4625541,68.7182477,0,0,0,NULL,'{\"distance\":6.995580596887675,\"totalDistance\":23259.232139504205,\"motion\":false}',0,'null','null'),(451,'osmand',4,'2026-05-24 14:08:15','2026-05-24 14:08:13','2026-05-24 14:08:13','',25.4631318,68.717693,0,0,0,NULL,'{\"distance\":85.11077834333689,\"totalDistance\":23344.34291784754,\"motion\":false}',0,'null','null'),(452,'osmand',4,'2026-05-24 14:13:28','2026-05-24 14:13:23','2026-05-24 14:13:23','',25.4630697,68.7178758,0,0,0,NULL,'{\"distance\":19.630042644049066,\"totalDistance\":23363.972960491592,\"motion\":false}',0,'null','null'),(453,'osmand',4,'2026-05-24 14:17:29','2026-05-24 14:17:27','2026-05-24 14:17:27','',25.4634772,68.7165041,0,0,0,NULL,'{\"distance\":145.13542287437673,\"totalDistance\":23509.10838336597,\"motion\":false}',0,'null','null'),(454,'osmand',4,'2026-05-24 14:22:02','2026-05-24 14:22:00','2026-05-24 14:22:00','',25.4633792,68.7170513,0,0,0,NULL,'{\"distance\":56.068390527526404,\"totalDistance\":23565.176773893494,\"motion\":false}',0,'null','null'),(455,'osmand',4,'2026-05-24 14:27:30','2026-05-24 14:27:28','2026-05-24 14:27:28','',25.4628034,68.7201623,0,0,0,NULL,'{\"distance\":319.17709432196347,\"totalDistance\":23884.353868215458,\"motion\":false}',0,'null','null'),(456,'osmand',4,'2026-05-24 14:32:34','2026-05-24 14:32:26','2026-05-24 14:32:26','',25.462462,68.7216595,0,0,0,NULL,'{\"distance\":155.2034121739672,\"totalDistance\":24039.557280389425,\"motion\":false}',0,'null','null'),(457,'osmand',4,'2026-05-24 14:37:35','2026-05-24 14:37:33','2026-05-24 14:37:33','',25.4625389,68.7216374,0,0,0,NULL,'{\"distance\":8.843944005323388,\"totalDistance\":24048.401224394747,\"motion\":false}',0,'null','null'),(458,'osmand',4,'2026-05-24 14:38:46','2026-05-24 14:38:44','2026-05-24 14:38:44','',25.4624093,68.7228583,0,0,0,NULL,'{\"distance\":123.55382067762997,\"totalDistance\":24171.955045072376,\"motion\":false}',0,'null','null'),(459,'osmand',4,'2026-05-24 14:40:05','2026-05-24 14:40:04','2026-05-24 14:40:04','',25.4610269,68.722722,0,0,0,NULL,'{\"distance\":154.49661147644463,\"totalDistance\":24326.45165654882,\"motion\":false}',0,'null','null'),(460,'osmand',4,'2026-05-24 14:42:44','2026-05-24 14:42:39','2026-05-24 14:42:39','',25.4612302,68.7225282,0,0,0,NULL,'{\"distance\":29.85937532263563,\"totalDistance\":24356.311031871453,\"motion\":false}',0,'null','null'),(461,'osmand',4,'2026-05-24 14:44:53','2026-05-24 14:44:51','2026-05-24 14:44:51','',25.463815,68.7223723,0,0,0,NULL,'{\"distance\":288.1649363142941,\"totalDistance\":24644.475968185747,\"motion\":false}',0,'null','null'),(462,'osmand',4,'2026-05-24 14:46:27','2026-05-24 14:46:26','2026-05-24 14:46:26','',25.4676934,68.7249186,0,0,0,NULL,'{\"distance\":501.8887506663695,\"totalDistance\":25146.364718852117,\"motion\":false}',0,'null','null'),(463,'osmand',4,'2026-05-24 14:48:45','2026-05-24 14:48:30','2026-05-24 14:48:30','',25.4640404,68.7225619,0,0,0,NULL,'{\"distance\":470.6014887118556,\"totalDistance\":25616.96620756397,\"motion\":false}',0,'null','null'),(464,'osmand',4,'2026-05-24 14:49:59','2026-05-24 14:49:58','2026-05-24 14:49:58','',25.4637243,68.7223766,0,0,0,NULL,'{\"distance\":39.812598157496424,\"totalDistance\":25656.778805721468,\"motion\":false}',0,'null','null'),(465,'osmand',4,'2026-05-24 14:53:39','2026-05-24 14:53:37','2026-05-24 14:53:37','',25.4681832,68.7254386,0,0,0,NULL,'{\"distance\":584.0215984926954,\"totalDistance\":26240.800404214162,\"motion\":false}',0,'null','null'),(466,'osmand',4,'2026-05-24 14:55:50','2026-05-24 14:55:48','2026-05-24 14:55:48','',25.4702324,68.7327129,0,0,0,NULL,'{\"distance\":765.8377636843796,\"totalDistance\":27006.63816789854,\"motion\":false}',0,'null','null'),(467,'osmand',4,'2026-05-24 15:00:58','2026-05-24 15:00:57','2026-05-24 15:00:57','',25.4769238,68.7657046,0,0,0,NULL,'{\"distance\":3398.224151569813,\"totalDistance\":30404.862319468353,\"motion\":false}',0,'null','null'),(468,'osmand',4,'2026-05-24 15:06:04','2026-05-24 15:06:01','2026-05-24 15:06:01','',25.4780667,68.7727465,0,0,0,NULL,'{\"distance\":719.0154421080778,\"totalDistance\":31123.87776157643,\"motion\":false}',0,'null','null'),(469,'osmand',4,'2026-05-24 15:11:07','2026-05-24 15:08:12','2026-05-24 15:08:12','',25.4781128,68.7728621,0,0,0,NULL,'{\"distance\":12.700074578576105,\"totalDistance\":31136.577836155007,\"motion\":false}',0,'null','null'),(470,'osmand',4,'2026-05-24 15:11:07','2026-05-24 15:11:05','2026-05-24 15:11:05','',25.4781172,68.7727945,0,0,0,NULL,'{\"distance\":6.811004291415249,\"totalDistance\":31143.388840446423,\"motion\":false}',0,'null','null'),(471,'osmand',4,'2026-05-24 15:21:25','2026-05-24 15:16:07','2026-05-24 15:16:07','',25.4736715,68.774625,0,0,0,NULL,'{\"distance\":527.9766241214077,\"totalDistance\":31671.365464567833,\"motion\":false}',0,'null','null'),(472,'osmand',4,'2026-05-24 15:21:25','2026-05-24 15:21:22','2026-05-24 15:21:22','',25.4603352,68.7819935,0,0,0,NULL,'{\"distance\":1659.04510096402,\"totalDistance\":33330.410565531856,\"motion\":false}',0,'null','null'),(473,'osmand',4,'2026-05-24 15:22:46','2026-05-24 15:22:44','2026-05-24 15:22:44','',25.4587802,68.7829088,0,0,0,NULL,'{\"distance\":196.02934055640472,\"totalDistance\":33526.439906088264,\"motion\":false}',0,'null','null'),(474,'osmand',4,'2026-05-24 15:27:47','2026-05-24 15:27:45','2026-05-24 15:27:45','',25.458757,68.7826671,0,0,0,NULL,'{\"distance\":24.43011067953429,\"totalDistance\":33550.870016767796,\"motion\":false}',0,'null','null'),(475,'osmand',4,'2026-05-24 15:28:50','2026-05-24 15:28:49','2026-05-24 15:28:49','',25.4589148,68.7828014,0,0,0,NULL,'{\"distance\":22.153561809076248,\"totalDistance\":33573.023578576875,\"motion\":false}',0,'null','null'),(476,'osmand',4,'2026-05-24 15:30:08','2026-05-24 15:30:07','2026-05-24 15:30:07','',25.4588174,68.7828193,0,0,0,NULL,'{\"distance\":10.99077122292213,\"totalDistance\":33584.0143497998,\"motion\":false}',0,'null','null'),(477,'osmand',4,'2026-05-24 15:31:37','2026-05-24 15:31:36','2026-05-24 15:31:36','',25.4586346,68.7828233,0,0,0,NULL,'{\"distance\":20.353174076334152,\"totalDistance\":33604.367523876135,\"motion\":false}',0,'null','null'),(478,'osmand',4,'2026-05-24 15:32:28','2026-05-24 15:32:28','2026-05-24 15:32:28','',25.4587363,68.7827967,0,0,0,NULL,'{\"distance\":11.632597694186588,\"totalDistance\":33616.00012157032,\"motion\":false}',0,'null','null'),(479,'osmand',4,'2026-05-25 03:52:03','2026-05-25 03:52:00','2026-05-25 03:52:00','',25.458901,68.7822554,0,0,0,NULL,'{\"distance\":57.41212841660089,\"totalDistance\":33673.412249986926,\"motion\":false}',0,'null','null'),(480,'osmand',4,'2026-05-25 04:08:40','2026-05-25 04:08:23','2026-05-25 04:08:23','',25.4492349,68.7521567,0,0,0,NULL,'{\"distance\":3210.9914675274686,\"totalDistance\":36884.4037175144,\"motion\":false}',0,'null','null'),(481,'osmand',4,'2026-05-25 04:08:44','2026-05-25 04:08:23','2026-05-25 04:08:23','',25.4492349,68.7521567,0,0,0,NULL,'{\"distance\":0.0,\"totalDistance\":36884.4037175144,\"motion\":false}',0,'null','null'),(482,'osmand',4,'2026-05-25 04:08:44','2026-05-25 04:08:24','2026-05-25 04:08:24','',25.449259,68.7521257,0,0,0,NULL,'{\"distance\":4.1118344902737265,\"totalDistance\":36888.51555200467,\"motion\":false}',0,'null','null'),(483,'osmand',4,'2026-05-25 04:58:03','2026-05-25 04:58:01','2026-05-25 04:58:01','',25.4043879,68.8818516,0,0,0,NULL,'{\"distance\":13965.987512802407,\"totalDistance\":50854.503064807075,\"motion\":false}',0,'null','null'),(484,'osmand',4,'2026-05-25 04:58:03','2026-05-25 04:58:01','2026-05-25 04:58:01','',25.4043879,68.8818516,0,0,0,NULL,'{\"distance\":0.0,\"totalDistance\":50854.503064807075,\"motion\":false}',0,'null','null'),(485,'osmand',4,'2026-05-25 04:58:03','2026-05-25 04:58:02','2026-05-25 04:58:02','',25.4043757,68.8818591,0,0,0,NULL,'{\"distance\":1.5534454068294699,\"totalDistance\":50856.05651021391,\"motion\":false}',0,'null','null'),(486,'osmand',4,'2026-05-25 04:58:04','2026-05-25 04:58:02','2026-05-25 04:58:02','',25.4043757,68.8818591,0,0,0,NULL,'{\"distance\":0.0,\"totalDistance\":50856.05651021391,\"motion\":false}',0,'null','null'),(487,'osmand',4,'2026-05-25 04:58:11','2026-05-25 04:58:10','2026-05-25 04:58:10','',25.4043805,68.8818592,0,0,0,NULL,'{\"distance\":0.5344281637366471,\"totalDistance\":50856.590938377645,\"motion\":false}',0,'null','null'),(488,'osmand',4,'2026-05-25 04:58:14','2026-05-25 04:58:13','2026-05-25 04:58:13','',25.4043832,68.8818683,0,0,0,NULL,'{\"distance\":0.9631501373959641,\"totalDistance\":50857.55408851504,\"motion\":false}',0,'null','null'),(489,'osmand',4,'2026-05-25 14:00:51','2026-05-25 14:00:49','2026-05-25 14:00:49','',25.4591568,68.7825092,0,0,0,NULL,'{\"distance\":11702.737397337445,\"totalDistance\":62560.29148585249,\"motion\":false}',0,'null','null'),(490,'laravel',5,'2026-05-29 17:22:39','2026-05-29 17:06:00','2026-05-29 17:06:00','',21.522136951686,39.151376979703,0,18.8985,120,NULL,'{\"battery\":100,\"ignition\":true,\"acc\":true,\"gsm\":5,\"sat\":8,\"odometer\":20,\"powerCut\":false,\"alarm\":false,\"gpsFix\":\"fix\"}',0,NULL,NULL),(491,'laravel',5,'2026-05-29 17:24:04','2026-05-29 17:06:00','2026-05-29 17:06:00','',21.523766071936,39.150826030158,0,18.8985,120,NULL,'{\"battery\":100,\"ignition\":true,\"acc\":true,\"gsm\":5,\"sat\":8,\"odometer\":20,\"powerCut\":false,\"alarm\":false,\"gpsFix\":\"fix\"}',0,NULL,NULL),(492,'laravel',5,'2026-05-29 17:27:17','2026-05-29 17:06:00','2026-05-29 17:06:00','',21.524461645804,39.150983444314,0,10.7991,15,NULL,'{\"battery\":100,\"ignition\":true,\"acc\":true,\"gsm\":4,\"sat\":85,\"odometer\":12,\"powerCut\":false,\"alarm\":false,\"gpsFix\":\"fix\"}',0,NULL,NULL),(493,'laravel',5,'2026-05-29 17:30:40','2026-05-29 17:06:00','2026-05-29 17:06:00','',21.52702425763,39.154112050662,0,10.7991,15,NULL,'{\"battery\":100,\"ignition\":true,\"acc\":true,\"gsm\":4,\"sat\":85,\"odometer\":12,\"powerCut\":false,\"alarm\":false,\"gpsFix\":\"fix\"}',0,NULL,NULL),(494,'laravel',5,'2026-05-29 17:31:08','2026-05-29 17:06:00','2026-05-29 17:06:00','',21.529147530324,39.157752253016,0,10.7991,15,NULL,'{\"battery\":100,\"ignition\":true,\"acc\":true,\"gsm\":4,\"sat\":85,\"odometer\":12,\"powerCut\":false,\"alarm\":false,\"gpsFix\":\"fix\"}',0,NULL,NULL),(495,'laravel',5,'2026-05-29 17:32:31','2026-05-29 17:06:00','2026-05-29 17:06:00','',21.529147530324,39.158185141945,0,21.5983,25,NULL,'{\"battery\":100,\"ignition\":true,\"acc\":true,\"gsm\":4,\"sat\":85,\"odometer\":12,\"powerCut\":false,\"alarm\":false,\"gpsFix\":\"fix\"}',0,NULL,NULL),(496,'laravel',5,'2026-05-29 17:33:00','2026-05-29 17:06:00','2026-05-29 17:06:00','',21.52922074607,39.159050919802,0,21.5983,25,NULL,'{\"battery\":100,\"ignition\":true,\"acc\":true,\"gsm\":4,\"sat\":85,\"odometer\":12,\"powerCut\":false,\"alarm\":false,\"gpsFix\":\"fix\"}',0,NULL,NULL),(497,'laravel',5,'2026-05-29 17:33:34','2026-05-29 17:06:00','2026-05-29 17:06:00','',21.529019402679,39.159739606734,0,21.5983,25,NULL,'{\"battery\":100,\"ignition\":true,\"acc\":true,\"gsm\":4,\"sat\":85,\"odometer\":12,\"powerCut\":false,\"alarm\":false,\"gpsFix\":\"fix\"}',0,NULL,NULL),(498,'laravel',5,'2026-05-29 17:35:00','2026-05-29 17:06:00','2026-05-29 17:06:00','',21.529129226407,39.160998920064,0,21.5983,25,NULL,'{\"battery\":100,\"ignition\":true,\"acc\":true,\"gsm\":4,\"sat\":85,\"odometer\":12,\"powerCut\":false,\"alarm\":false,\"gpsFix\":\"fix\"}',0,NULL,NULL),(499,'laravel',5,'2026-05-29 17:35:42','2026-05-29 17:06:00','2026-05-29 17:06:00','',21.531362290341,39.166547769058,0,64.7948,30,NULL,'{\"battery\":100,\"ignition\":true,\"acc\":true,\"gsm\":4,\"sat\":85,\"odometer\":12,\"powerCut\":false,\"alarm\":false,\"gpsFix\":\"fix\"}',0,NULL,NULL),(500,'laravel',5,'2026-05-29 17:37:12','2026-05-29 17:06:00','2026-05-29 17:06:00','',21.53292959573,39.170622872321,0,64.7948,30,NULL,'{\"battery\":100,\"ignition\":true,\"acc\":true,\"gsm\":4,\"sat\":85,\"odometer\":12,\"powerCut\":false,\"alarm\":false,\"gpsFix\":\"fix\"}',0,NULL,NULL),(501,'laravel',5,'2026-05-29 18:04:50','2026-05-29 17:06:00','2026-05-29 17:06:00','',21.533369374546,39.172888257543,0,64.7948,30,NULL,'{\"battery\":100,\"ignition\":true,\"acc\":true,\"gsm\":4,\"sat\":85,\"odometer\":12,\"powerCut\":false,\"alarm\":false,\"gpsFix\":\"fix\"}',0,NULL,NULL),(502,'laravel',5,'2026-05-30 00:28:38','2026-05-29 17:06:00','2026-05-29 17:06:00','',21.533693808742,39.174398869128,0,21.5983,30,NULL,'{\"battery\":100,\"ignition\":true,\"acc\":true,\"gsm\":4,\"sat\":85,\"odometer\":12,\"powerCut\":false,\"alarm\":false,\"gpsFix\":\"fix\"}',0,NULL,NULL),(503,'laravel',5,'2026-05-30 00:38:19','2026-05-29 17:06:00','2026-05-29 17:06:00','',21.532764247655,39.174609745525,0,0,10,NULL,'{\"battery\":100,\"ignition\":true,\"acc\":true,\"gsm\":4,\"sat\":85,\"odometer\":12,\"powerCut\":false,\"alarm\":false,\"gpsFix\":\"fix\"}',0,NULL,NULL),(504,'laravel',5,'2026-05-30 00:39:57','2026-05-29 17:06:00','2026-05-29 17:06:00','',21.532764247655,39.174609745525,0,0,10,NULL,'{\"battery\":100,\"ignition\":false,\"acc\":false,\"gsm\":4,\"sat\":85,\"odometer\":12,\"powerCut\":false,\"alarm\":false,\"gpsFix\":\"fix\"}',0,NULL,NULL),(505,'osmand',6,'2026-05-29 21:51:18','2026-05-29 21:51:15','2026-05-29 21:51:15','',25.4587663,68.7827618,0,0,0,NULL,'{\"distance\":0.0,\"totalDistance\":0.0,\"motion\":false}',0,'null','null'),(506,'osmand',6,'2026-05-29 21:51:19','2026-05-29 21:51:18','2026-05-29 21:51:18','',25.4589017,68.7825717,0,0,0,NULL,'{\"distance\":24.336366745126366,\"totalDistance\":24.336366745126366,\"motion\":false}',0,'null','null'),(507,'osmand',6,'2026-05-29 22:01:14','2026-05-29 22:01:14','2026-05-29 21:51:18','',25.4589017,68.7825717,0,0,0,NULL,'{\"notificationToken\":\"c04Q44hfQGyxm_gcVJmhxK:APA91bEt61-irYKjfwE3fgLUpaI6jTg33TuqKEZSYOkIU59pxYy5odFUtIP0spfyoMbFLXOdkORaCveTqe-o5F4js-AvEIkHE6DDdMbE9ZuC2SpJ6CDEQ14\",\"distance\":0.0,\"totalDistance\":24.336366745126366,\"motion\":false}',0,'null','null'),(508,'osmand',6,'2026-05-29 22:01:16','2026-05-29 22:01:15','2026-05-29 22:01:15','',25.4587682,68.7827488,0,0,0,NULL,'{\"distance\":23.18843740806641,\"totalDistance\":47.524804153192775,\"motion\":false}',0,'null','null'),(509,'osmand',6,'2026-05-29 22:01:16','2026-05-29 22:01:15','2026-05-29 22:01:15','',25.4587682,68.7827488,0,0,0,NULL,'{\"distance\":0.0,\"totalDistance\":47.524804153192775,\"motion\":false}',0,'null','null'),(510,'osmand',6,'2026-05-29 22:01:26','2026-05-29 22:01:25','2026-05-29 22:01:25','',25.4588367,68.78243,0,0,0,NULL,'{\"distance\":32.93735253324403,\"totalDistance\":80.4621566864368,\"motion\":false}',0,'null','null'),(511,'osmand',6,'2026-05-30 06:01:54','2026-05-30 06:01:54','2026-05-30 06:01:54','',25.4587433,68.7826667,0,0,0,NULL,'{\"distance\":25.963403505684077,\"totalDistance\":106.42556019212088,\"motion\":false}',0,'null','null'),(512,'osmand',6,'2026-05-30 07:05:05','2026-05-30 07:05:05','2026-05-30 07:05:05','',25.4588358,68.7826663,0,0,0,NULL,'{\"distance\":10.297131384446253,\"totalDistance\":116.72269157656714,\"motion\":false}',0,'null','null'),(513,'osmand',6,'2026-05-30 07:05:07','2026-05-30 07:05:07','2026-05-30 07:05:07','',25.4589672,68.7826924,0,0,0,NULL,'{\"distance\":14.860753513376881,\"totalDistance\":131.58344508994404,\"motion\":false}',0,'null','null'),(514,'osmand',6,'2026-05-30 07:05:19','2026-05-30 07:05:18','2026-05-30 07:05:18','',25.4589258,68.7827167,0,0,0,NULL,'{\"distance\":5.215810938974606,\"totalDistance\":136.79925602891865,\"motion\":false}',0,'null','null'),(515,'laravel',5,'2026-05-30 16:15:23','2026-05-29 17:06:00','2026-05-29 17:06:00','',21.532764247655,39.174609745525,0,0,10,NULL,'{\"battery\":100,\"ignition\":true,\"acc\":true,\"gsm\":4,\"sat\":85,\"odometer\":12,\"powerCut\":false,\"alarm\":false,\"gpsFix\":\"fix\"}',0,NULL,NULL),(516,'laravel',5,'2026-05-30 16:15:50','2026-05-29 17:06:00','2026-05-29 17:06:00','',21.532764247655,39.174609745525,0,0,10,NULL,'{\"battery\":100,\"ignition\":true,\"acc\":true,\"gsm\":4,\"sat\":85,\"odometer\":12,\"powerCut\":false,\"alarm\":false,\"gpsFix\":\"fix\"}',0,NULL,NULL),(517,'laravel',5,'2026-05-30 16:18:02','2026-05-29 17:06:00','2026-05-29 17:06:00','',21.531486012948,39.174868459701,0,2.15983,10,NULL,'{\"battery\":100,\"ignition\":true,\"acc\":true,\"gsm\":4,\"sat\":85,\"odometer\":12,\"powerCut\":false,\"alarm\":false,\"gpsFix\":\"fix\"}',0,NULL,NULL),(518,'laravel',5,'2026-05-30 16:19:10','2026-05-29 17:06:00','2026-05-29 17:06:00','',21.529894867513,39.175252991243,0,21.5983,10,NULL,'{\"battery\":100,\"ignition\":true,\"acc\":true,\"gsm\":4,\"sat\":85,\"odometer\":12,\"powerCut\":false,\"alarm\":false,\"gpsFix\":\"fix\"}',0,NULL,NULL),(519,'osmand',6,'2026-05-30 15:46:39','2026-05-30 13:38:13','2026-05-30 13:38:13','',25.4638738,68.7177235,0,0,0,NULL,'{\"distance\":6555.491510251886,\"totalDistance\":6692.290766280805,\"motion\":false}',0,'null','null'),(520,'osmand',6,'2026-05-30 15:46:39','2026-05-30 13:43:04','2026-05-30 13:43:04','',25.4631339,68.7178099,0,0,0,NULL,'{\"distance\":82.82178413148266,\"totalDistance\":6775.112550412287,\"motion\":false}',0,'null','null'),(521,'osmand',6,'2026-05-30 15:46:40','2026-05-30 13:53:49','2026-05-30 13:53:49','',25.4634311,68.7165884,0,0,0,NULL,'{\"distance\":127.14782742218442,\"totalDistance\":6902.260377834472,\"motion\":false}',0,'null','null'),(522,'osmand',6,'2026-05-30 15:46:40','2026-05-30 14:04:16','2026-05-30 14:04:16','',25.4631197,68.717877,0,0,0,NULL,'{\"distance\":134.0709937669734,\"totalDistance\":7036.331371601445,\"motion\":false}',0,'null','null'),(523,'osmand',6,'2026-05-30 15:46:41','2026-05-30 14:28:59','2026-05-30 14:28:59','',25.4628549,68.7166427,0,0,0,NULL,'{\"distance\":127.50895383620956,\"totalDistance\":7163.840325437655,\"motion\":false}',0,'null','null'),(524,'osmand',6,'2026-05-30 15:46:41','2026-05-30 14:53:47','2026-05-30 14:53:47','',25.4681587,68.72541,0,0,0,NULL,'{\"distance\":1060.6682214832304,\"totalDistance\":8224.508546920886,\"motion\":false}',0,'null','null'),(525,'osmand',6,'2026-05-30 15:46:41','2026-05-30 15:04:01','2026-05-30 15:04:01','',25.4722562,68.7751424,0,0,0,NULL,'{\"distance\":5018.888398808874,\"totalDistance\":13243.39694572976,\"motion\":false}',0,'null','null'),(526,'osmand',6,'2026-05-30 15:46:41','2026-05-30 15:09:18','2026-05-30 15:09:18','',25.4587799,68.7828038,0,0,0,NULL,'{\"distance\":1686.2468750745181,\"totalDistance\":14929.643820804278,\"motion\":false}',0,'null','null'),(527,'osmand',6,'2026-05-30 15:46:44','2026-05-30 15:46:42','2026-05-30 15:46:42','',25.4587844,68.782659,0,0,0,NULL,'{\"distance\":14.562435281239786,\"totalDistance\":14944.206256085517,\"motion\":false}',0,'null','null'),(528,'osmand',6,'2026-05-30 15:46:44','2026-05-30 15:46:42','2026-05-30 15:46:42','',25.4587844,68.782659,0,0,0,NULL,'{\"distance\":0.0,\"totalDistance\":14944.206256085517,\"motion\":false}',0,'null','null'),(529,'osmand',6,'2026-05-30 15:46:45','2026-05-30 15:46:45','2026-05-30 15:46:45','',25.4583914,68.7820821,0,0,0,NULL,'{\"distance\":72.63678525102819,\"totalDistance\":15016.843041336546,\"motion\":false}',0,'null','null'),(530,'osmand',6,'2026-05-30 15:46:45','2026-05-30 15:46:45','2026-05-30 15:46:45','',25.4583914,68.7820821,0,0,0,NULL,'{\"distance\":0.0,\"totalDistance\":15016.843041336546,\"motion\":false}',0,'null','null'),(531,'osmand',6,'2026-05-30 15:46:45','2026-05-30 15:46:45','2026-05-30 15:46:45','',25.4583914,68.7820821,0,0,0,NULL,'{\"distance\":0.0,\"totalDistance\":15016.843041336546,\"motion\":false}',0,'null','null'),(532,'osmand',6,'2026-05-30 15:47:30','2026-05-30 15:47:29','2026-05-30 15:47:29','',25.458605,68.7824683,0,0,0,NULL,'{\"distance\":45.52079758319853,\"totalDistance\":15062.363838919744,\"motion\":false}',0,'null','null'),(533,'laravel',5,'2026-05-31 03:09:54','2026-05-29 17:06:00','2026-05-29 17:06:00','',21.529894867513,39.175252991243,0,21.5983,10,NULL,'{\"battery\":100,\"ignition\":true,\"acc\":true,\"gsm\":4,\"sat\":85,\"odometer\":12,\"powerCut\":false,\"alarm\":false,\"gpsFix\":\"fix\"}',0,NULL,NULL),(534,'laravel',5,'2026-05-31 12:59:05','2026-05-31 12:59:05','2026-05-31 12:59:05','',21.527933775049,39.175706579462,0,26.9979,10,NULL,'{\"battery\":100,\"ignition\":true,\"acc\":true,\"gsm\":4,\"sat\":85,\"odometer\":12,\"powerCut\":false,\"alarm\":false,\"gpsFix\":\"fix\"}',0,NULL,NULL),(535,'laravel',5,'2026-05-31 13:00:15','2026-05-31 13:00:15','2026-05-31 13:00:15','',21.527943725502,39.175693858347,0,26.9979,10,NULL,'{\"battery\":100,\"ignition\":true,\"acc\":true,\"gsm\":4,\"sat\":85,\"odometer\":12,\"powerCut\":false,\"alarm\":false,\"gpsFix\":\"fix\"}',0,NULL,NULL),(536,'laravel',5,'2026-05-31 13:11:45','2026-05-31 13:11:45','2026-05-31 13:11:45','',21.527640104165,39.174858925897,0,45.8963,15,NULL,'{\"battery\":85,\"ignition\":true,\"acc\":true,\"gsm\":5,\"sat\":85,\"odometer\":12,\"powerCut\":false,\"alarm\":false,\"gpsFix\":\"fix\"}',0,NULL,NULL),(537,'laravel',5,'2026-05-31 13:26:40','2026-05-31 13:26:40','2026-05-31 13:26:40','',21.527408508675,39.174316362156,0,45.8963,15,NULL,'{\"battery\":85,\"ignition\":true,\"acc\":true,\"gsm\":5,\"sat\":85,\"odometer\":12,\"powerCut\":false,\"alarm\":false,\"gpsFix\":\"fix\"}',0,NULL,NULL),(538,'laravel',5,'2026-05-31 13:29:00','2026-05-31 13:29:00','2026-05-31 13:29:00','',21.527007768005,39.173314202434,0,48.5961,20,NULL,'{\"battery\":75,\"ignition\":true,\"acc\":true,\"gsm\":53,\"sat\":70,\"odometer\":24,\"powerCut\":false,\"alarm\":false,\"gpsFix\":\"fix\"}',0,NULL,NULL),(539,'osmand',6,'2026-06-03 16:58:28','2026-06-03 16:58:27','2026-06-03 16:58:27','',25.4587488,68.7826635,0,0,0,NULL,'{\"distance\":25.32140736673772,\"totalDistance\":15087.68524628648,\"motion\":false}',0,'null','null'),(540,'laravel',5,'2026-06-05 00:52:59','2026-05-31 14:55:00','2026-05-31 14:55:00','',21.535069019719,39.209210013827,0,49.676,10,NULL,'{\"battery\":75,\"ignition\":true,\"acc\":true,\"gsm\":53,\"sat\":70,\"odometer\":24,\"powerCut\":false,\"alarm\":false,\"gpsFix\":\"fix\"}',0,NULL,NULL),(541,'laravel',5,'2026-06-05 00:57:11','2026-06-05 00:57:11','2026-06-05 00:57:11','',21.535069019719,39.209210013827,0,49.676,10,NULL,'{\"battery\":75,\"ignition\":true,\"acc\":true,\"gsm\":53,\"sat\":70,\"odometer\":24,\"powerCut\":false,\"alarm\":false,\"gpsFix\":\"fix\"}',0,NULL,NULL),(542,'laravel',7,'2026-06-05 02:42:51','2026-06-05 02:40:00','2026-06-05 02:40:00','',25.466743791627,68.718687342149,0,43.1966,5,NULL,'{\"battery\":75,\"ignition\":true,\"acc\":true,\"gsm\":5,\"sat\":50,\"odometer\":80,\"powerCut\":false,\"alarm\":false,\"gpsFix\":\"fix\"}',0,NULL,NULL),(543,'laravel',7,'2026-06-05 02:43:57','2026-06-05 02:43:45','2026-06-05 02:43:45','',25.467043570687,68.71850779334,0,43.1966,5,NULL,'{\"battery\":75,\"ignition\":true,\"acc\":true,\"gsm\":5,\"sat\":50,\"odometer\":80,\"powerCut\":false,\"alarm\":false,\"gpsFix\":\"fix\"}',0,NULL,NULL),(544,'laravel',7,'2026-06-05 02:45:02','2026-06-05 02:43:59','2026-06-05 02:43:59','',25.467159040941,68.718579120949,0,21.5983,5,NULL,'{\"battery\":75,\"ignition\":true,\"acc\":true,\"gsm\":5,\"sat\":50,\"odometer\":80,\"powerCut\":false,\"alarm\":false,\"gpsFix\":\"fix\"}',0,NULL,NULL),(545,'laravel',7,'2026-06-05 02:45:50','2026-06-05 02:44:59','2026-06-05 02:44:59','',25.467389981115,68.718500414622,0,24.2981,5,NULL,'{\"battery\":75,\"ignition\":true,\"acc\":true,\"gsm\":5,\"sat\":50,\"odometer\":80,\"powerCut\":false,\"alarm\":false,\"gpsFix\":\"fix\"}',0,NULL,NULL),(546,'laravel',7,'2026-06-05 02:46:47','2026-06-05 02:45:59','2026-06-05 02:45:59','',25.46760094266,68.718318402425,0,48.5961,5,NULL,'{\"battery\":75,\"ignition\":true,\"acc\":true,\"gsm\":5,\"sat\":50,\"odometer\":80,\"powerCut\":false,\"alarm\":false,\"gpsFix\":\"fix\"}',0,NULL,NULL),(547,'laravel',7,'2026-06-05 02:47:34','2026-06-05 02:46:59','2026-06-05 02:46:59','',25.467688704317,68.718357435935,0,48.5961,5,NULL,'{\"battery\":75,\"ignition\":true,\"acc\":true,\"gsm\":5,\"sat\":50,\"odometer\":80,\"powerCut\":false,\"alarm\":false,\"gpsFix\":\"fix\"}',0,NULL,NULL),(548,'laravel',7,'2026-06-05 02:48:13','2026-06-05 02:47:59','2026-06-05 02:47:59','',25.467848767494,68.718620910086,0,48.5961,5,NULL,'{\"battery\":75,\"ignition\":true,\"acc\":true,\"gsm\":5,\"sat\":50,\"odometer\":80,\"powerCut\":false,\"alarm\":false,\"gpsFix\":\"fix\"}',0,NULL,NULL),(549,'laravel',7,'2026-06-05 02:48:52','2026-06-05 02:48:59','2026-06-05 02:48:59','',25.467848026461,68.718617626919,0,48.5961,5,NULL,'{\"battery\":75,\"ignition\":true,\"acc\":true,\"gsm\":5,\"sat\":50,\"odometer\":80,\"powerCut\":false,\"alarm\":false,\"gpsFix\":\"fix\"}',0,NULL,NULL),(550,'laravel',7,'2026-06-05 02:50:08','2026-06-05 02:49:59','2026-06-05 02:49:59','',25.468051810293,68.718974671335,0,48.5961,5,NULL,'{\"battery\":75,\"ignition\":true,\"acc\":true,\"gsm\":5,\"sat\":50,\"odometer\":80,\"powerCut\":false,\"alarm\":false,\"gpsFix\":\"fix\"}',0,NULL,NULL),(551,'laravel',7,'2026-06-05 02:50:50','2026-06-05 02:50:59','2026-06-05 02:50:59','',25.46787173951,68.719203672245,0,48.5961,5,NULL,'{\"battery\":75,\"ignition\":true,\"acc\":true,\"gsm\":5,\"sat\":50,\"odometer\":80,\"powerCut\":false,\"alarm\":false,\"gpsFix\":\"fix\"}',0,NULL,NULL),(552,'laravel',7,'2026-06-05 02:51:24','2026-06-05 02:50:59','2026-06-05 02:50:59','',25.467870257445,68.71935633951,0,48.5961,5,NULL,'{\"battery\":75,\"ignition\":true,\"acc\":true,\"gsm\":5,\"sat\":50,\"odometer\":80,\"powerCut\":false,\"alarm\":false,\"gpsFix\":\"fix\"}',0,NULL,NULL),(553,'laravel',7,'2026-06-05 02:52:13','2026-06-05 02:51:59','2026-06-05 02:51:59','',25.467687963287,68.719464684021,0,48.5961,5,NULL,'{\"battery\":75,\"ignition\":true,\"acc\":true,\"gsm\":5,\"sat\":50,\"odometer\":80,\"powerCut\":false,\"alarm\":false,\"gpsFix\":\"fix\"}',0,NULL,NULL),(554,'laravel',7,'2026-06-05 02:53:15','2026-06-05 02:52:59','2026-06-05 02:52:59','',25.467725645856,68.719606215108,0,48.5961,5,NULL,'{\"battery\":75,\"ignition\":true,\"acc\":true,\"gsm\":5,\"sat\":50,\"odometer\":80,\"powerCut\":false,\"alarm\":false,\"gpsFix\":\"fix\"}',0,NULL,NULL),(555,'laravel',7,'2026-06-05 02:53:51','2026-06-05 02:53:59','2026-06-05 02:53:59','',25.467938566649,68.719864611431,0,48.5961,5,NULL,'{\"battery\":75,\"ignition\":true,\"acc\":true,\"gsm\":5,\"sat\":50,\"odometer\":80,\"powerCut\":false,\"alarm\":false,\"gpsFix\":\"fix\"}',0,NULL,NULL),(556,'laravel',7,'2026-06-05 02:54:47','2026-06-05 02:54:59','2026-06-05 02:54:59','',25.468088885364,68.720270318138,0,48.5961,5,NULL,'{\"battery\":75,\"ignition\":true,\"acc\":true,\"gsm\":5,\"sat\":50,\"odometer\":80,\"powerCut\":false,\"alarm\":false,\"gpsFix\":\"fix\"}',0,NULL,NULL),(557,'laravel',7,'2026-06-05 02:55:18','2026-06-05 02:54:59','2026-06-05 02:54:59','',25.468494617219,68.720890218799,0,48.5961,5,NULL,'{\"battery\":75,\"ignition\":true,\"acc\":true,\"gsm\":5,\"sat\":50,\"odometer\":80,\"powerCut\":false,\"alarm\":false,\"gpsFix\":\"fix\"}',0,NULL,NULL),(558,'laravel',7,'2026-06-05 03:01:35','2026-06-05 03:00:59','2026-06-05 03:00:59','',25.468614734948,68.721281475673,0,48.5961,5,NULL,'{\"battery\":75,\"ignition\":true,\"acc\":true,\"gsm\":5,\"sat\":50,\"odometer\":80,\"powerCut\":false,\"alarm\":false,\"gpsFix\":\"fix\"}',0,NULL,NULL),(559,'laravel',7,'2026-06-05 03:03:20','2026-06-05 03:02:59','2026-06-05 03:02:59','',25.468011072901,68.721343647985,0,48.5961,5,NULL,'{\"battery\":75,\"ignition\":true,\"acc\":true,\"gsm\":5,\"sat\":50,\"odometer\":80,\"powerCut\":false,\"alarm\":false,\"gpsFix\":\"fix\"}',0,NULL,NULL),(560,'laravel',7,'2026-06-05 03:03:55','2026-06-05 03:03:59','2026-06-05 03:03:59','',25.467550065484,68.721489034666,0,48.5961,5,NULL,'{\"battery\":75,\"ignition\":true,\"acc\":true,\"gsm\":5,\"sat\":50,\"odometer\":80,\"powerCut\":false,\"alarm\":false,\"gpsFix\":\"fix\"}',0,NULL,NULL),(561,'laravel',7,'2026-06-05 03:04:23','2026-06-05 03:03:59','2026-06-05 03:03:59','',25.467095459217,68.721754985912,0,48.5961,5,NULL,'{\"battery\":75,\"ignition\":true,\"acc\":true,\"gsm\":5,\"sat\":50,\"odometer\":80,\"powerCut\":false,\"alarm\":false,\"gpsFix\":\"fix\"}',0,NULL,NULL),(562,'laravel',7,'2026-06-05 03:04:52','2026-06-05 03:04:59','2026-06-05 03:04:59','',25.467095459217,68.721754985912,0,0.539957,5,NULL,'{\"battery\":75,\"ignition\":true,\"acc\":true,\"gsm\":5,\"sat\":50,\"odometer\":80,\"powerCut\":false,\"alarm\":false,\"gpsFix\":\"fix\"}',0,NULL,NULL),(563,'laravel',7,'2026-06-05 03:05:04','2026-06-05 03:04:59','2026-06-05 03:04:59','',25.467095459217,68.721754985912,0,0,5,NULL,'{\"battery\":75,\"ignition\":true,\"acc\":true,\"gsm\":5,\"sat\":50,\"odometer\":80,\"powerCut\":false,\"alarm\":false,\"gpsFix\":\"fix\"}',0,NULL,NULL),(564,'laravel',7,'2026-06-05 03:05:16','2026-06-05 03:04:59','2026-06-05 03:04:59','',25.467095459217,68.721754985912,0,0,5,NULL,'{\"battery\":75,\"ignition\":false,\"acc\":false,\"gsm\":5,\"sat\":50,\"odometer\":80,\"powerCut\":false,\"alarm\":false,\"gpsFix\":\"fix\"}',0,NULL,NULL);

/*Table structure for table `tc_reports` */

DROP TABLE IF EXISTS `tc_reports`;

CREATE TABLE `tc_reports` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(32) NOT NULL,
  `description` varchar(128) NOT NULL,
  `calendarid` int NOT NULL,
  `attributes` varchar(4000) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_reports_calendarid` (`calendarid`),
  CONSTRAINT `fk_reports_calendarid` FOREIGN KEY (`calendarid`) REFERENCES `tc_calendars` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `tc_reports` */

/*Table structure for table `tc_servers` */

DROP TABLE IF EXISTS `tc_servers`;

CREATE TABLE `tc_servers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `registration` bit(1) NOT NULL DEFAULT b'0',
  `latitude` double NOT NULL DEFAULT '0',
  `longitude` double NOT NULL DEFAULT '0',
  `zoom` int NOT NULL DEFAULT '0',
  `map` varchar(128) DEFAULT NULL,
  `bingkey` varchar(128) DEFAULT NULL,
  `mapurl` varchar(512) DEFAULT NULL,
  `readonly` bit(1) NOT NULL DEFAULT b'0',
  `attributes` varchar(4000) DEFAULT NULL,
  `forcesettings` bit(1) NOT NULL DEFAULT b'0',
  `coordinateformat` varchar(128) DEFAULT NULL,
  `devicereadonly` bit(1) DEFAULT b'0',
  `limitcommands` bit(1) DEFAULT b'0',
  `poilayer` varchar(512) DEFAULT NULL,
  `announcement` varchar(4000) DEFAULT NULL,
  `disablereports` bit(1) DEFAULT b'0',
  `overlayurl` varchar(512) DEFAULT NULL,
  `fixedemail` bit(1) DEFAULT b'0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `tc_servers` */

insert  into `tc_servers`(`id`,`registration`,`latitude`,`longitude`,`zoom`,`map`,`bingkey`,`mapurl`,`readonly`,`attributes`,`forcesettings`,`coordinateformat`,`devicereadonly`,`limitcommands`,`poilayer`,`announcement`,`disablereports`,`overlayurl`,`fixedemail`) values (1,'\0',0,0,0,NULL,NULL,NULL,'\0',NULL,'\0',NULL,'\0','\0',NULL,NULL,'\0',NULL,'\0');

/*Table structure for table `tc_statistics` */

DROP TABLE IF EXISTS `tc_statistics`;

CREATE TABLE `tc_statistics` (
  `id` int NOT NULL AUTO_INCREMENT,
  `capturetime` timestamp NOT NULL,
  `activeusers` int NOT NULL DEFAULT '0',
  `activedevices` int NOT NULL DEFAULT '0',
  `requests` int NOT NULL DEFAULT '0',
  `messagesreceived` int NOT NULL DEFAULT '0',
  `messagesstored` int NOT NULL DEFAULT '0',
  `attributes` varchar(4096) NOT NULL,
  `mailsent` int NOT NULL DEFAULT '0',
  `smssent` int NOT NULL DEFAULT '0',
  `geocoderrequests` int NOT NULL DEFAULT '0',
  `geolocationrequests` int NOT NULL DEFAULT '0',
  `protocols` varchar(4096) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `tc_statistics` */

insert  into `tc_statistics`(`id`,`capturetime`,`activeusers`,`activedevices`,`requests`,`messagesreceived`,`messagesstored`,`attributes`,`mailsent`,`smssent`,`geocoderrequests`,`geolocationrequests`,`protocols`) values (1,'2026-05-24 03:42:40',2,0,125,0,0,'{}',0,0,0,0,'null'),(2,'2026-05-25 03:52:03',2,2,43,484,477,'{}',0,0,1,0,'{\"osmand\":2}'),(3,'2026-05-26 11:00:37',0,1,0,23,11,'{}',0,0,0,0,'{\"osmand\":1}'),(4,'2026-05-27 16:17:16',0,0,0,8,0,'{}',0,0,0,0,'null'),(5,'2026-05-29 20:58:49',1,0,7,5,0,'{}',0,0,0,0,'null'),(6,'2026-05-30 06:01:54',2,1,89,35,6,'{}',0,0,0,0,'{\"osmand\":1}'),(7,'2026-05-31 00:58:46',0,1,0,18,18,'{}',0,0,0,0,'{\"osmand\":1}'),(8,'2026-06-01 01:47:27',0,0,0,56,0,'{}',0,0,0,0,'null'),(9,'2026-06-02 03:06:08',0,0,0,6,0,'{}',0,0,0,0,'null'),(10,'2026-06-03 11:53:56',0,0,0,14,0,'{}',0,0,0,0,'null'),(11,'2026-06-05 16:56:32',0,0,0,9,0,'{}',0,0,0,0,'null'),(12,'2026-06-06 10:39:58',0,0,0,6,0,'{}',0,0,0,0,'null');

/*Table structure for table `tc_user_attribute` */

DROP TABLE IF EXISTS `tc_user_attribute`;

CREATE TABLE `tc_user_attribute` (
  `userid` int NOT NULL,
  `attributeid` int NOT NULL,
  KEY `fk_user_attribute_attributeid` (`attributeid`),
  KEY `fk_user_attribute_userid` (`userid`),
  CONSTRAINT `fk_user_attribute_attributeid` FOREIGN KEY (`attributeid`) REFERENCES `tc_attributes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_user_attribute_userid` FOREIGN KEY (`userid`) REFERENCES `tc_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `tc_user_attribute` */

/*Table structure for table `tc_user_calendar` */

DROP TABLE IF EXISTS `tc_user_calendar`;

CREATE TABLE `tc_user_calendar` (
  `userid` int NOT NULL,
  `calendarid` int NOT NULL,
  KEY `fk_user_calendar_calendarid` (`calendarid`),
  KEY `fk_user_calendar_userid` (`userid`),
  CONSTRAINT `fk_user_calendar_calendarid` FOREIGN KEY (`calendarid`) REFERENCES `tc_calendars` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_user_calendar_userid` FOREIGN KEY (`userid`) REFERENCES `tc_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `tc_user_calendar` */

/*Table structure for table `tc_user_command` */

DROP TABLE IF EXISTS `tc_user_command`;

CREATE TABLE `tc_user_command` (
  `userid` int NOT NULL,
  `commandid` int NOT NULL,
  KEY `fk_user_command_commandid` (`commandid`),
  KEY `fk_user_command_userid` (`userid`),
  CONSTRAINT `fk_user_command_commandid` FOREIGN KEY (`commandid`) REFERENCES `tc_commands` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_user_command_userid` FOREIGN KEY (`userid`) REFERENCES `tc_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `tc_user_command` */

/*Table structure for table `tc_user_device` */

DROP TABLE IF EXISTS `tc_user_device`;

CREATE TABLE `tc_user_device` (
  `userid` int NOT NULL,
  `deviceid` int NOT NULL,
  KEY `fk_user_device_deviceid` (`deviceid`),
  KEY `user_device_user_id` (`userid`),
  CONSTRAINT `fk_user_device_deviceid` FOREIGN KEY (`deviceid`) REFERENCES `tc_devices` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_user_device_userid` FOREIGN KEY (`userid`) REFERENCES `tc_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `tc_user_device` */

insert  into `tc_user_device`(`userid`,`deviceid`) values (7,6),(6,5),(9,7);

/*Table structure for table `tc_user_driver` */

DROP TABLE IF EXISTS `tc_user_driver`;

CREATE TABLE `tc_user_driver` (
  `userid` int NOT NULL,
  `driverid` int NOT NULL,
  KEY `fk_user_driver_driverid` (`driverid`),
  KEY `fk_user_driver_userid` (`userid`),
  CONSTRAINT `fk_user_driver_driverid` FOREIGN KEY (`driverid`) REFERENCES `tc_drivers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_user_driver_userid` FOREIGN KEY (`userid`) REFERENCES `tc_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `tc_user_driver` */

/*Table structure for table `tc_user_geofence` */

DROP TABLE IF EXISTS `tc_user_geofence`;

CREATE TABLE `tc_user_geofence` (
  `userid` int NOT NULL,
  `geofenceid` int NOT NULL,
  KEY `fk_user_geofence_geofenceid` (`geofenceid`),
  KEY `fk_user_geofence_userid` (`userid`),
  CONSTRAINT `fk_user_geofence_geofenceid` FOREIGN KEY (`geofenceid`) REFERENCES `tc_geofences` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_user_geofence_userid` FOREIGN KEY (`userid`) REFERENCES `tc_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `tc_user_geofence` */

/*Table structure for table `tc_user_group` */

DROP TABLE IF EXISTS `tc_user_group`;

CREATE TABLE `tc_user_group` (
  `userid` int NOT NULL,
  `groupid` int NOT NULL,
  KEY `fk_user_group_groupid` (`groupid`),
  KEY `fk_user_group_userid` (`userid`),
  CONSTRAINT `fk_user_group_groupid` FOREIGN KEY (`groupid`) REFERENCES `tc_groups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_user_group_userid` FOREIGN KEY (`userid`) REFERENCES `tc_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `tc_user_group` */

/*Table structure for table `tc_user_maintenance` */

DROP TABLE IF EXISTS `tc_user_maintenance`;

CREATE TABLE `tc_user_maintenance` (
  `userid` int NOT NULL,
  `maintenanceid` int NOT NULL,
  KEY `fk_user_maintenance_maintenanceid` (`maintenanceid`),
  KEY `fk_user_maintenance_userid` (`userid`),
  CONSTRAINT `fk_user_maintenance_maintenanceid` FOREIGN KEY (`maintenanceid`) REFERENCES `tc_maintenances` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_user_maintenance_userid` FOREIGN KEY (`userid`) REFERENCES `tc_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `tc_user_maintenance` */

/*Table structure for table `tc_user_notification` */

DROP TABLE IF EXISTS `tc_user_notification`;

CREATE TABLE `tc_user_notification` (
  `userid` int NOT NULL,
  `notificationid` int NOT NULL,
  KEY `fk_user_notification_notificationid` (`notificationid`),
  KEY `fk_user_notification_userid` (`userid`),
  CONSTRAINT `fk_user_notification_notificationid` FOREIGN KEY (`notificationid`) REFERENCES `tc_notifications` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_user_notification_userid` FOREIGN KEY (`userid`) REFERENCES `tc_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `tc_user_notification` */

/*Table structure for table `tc_user_order` */

DROP TABLE IF EXISTS `tc_user_order`;

CREATE TABLE `tc_user_order` (
  `userid` int NOT NULL,
  `orderid` int NOT NULL,
  KEY `fk_user_order_userid` (`userid`),
  KEY `fk_user_order_orderid` (`orderid`),
  CONSTRAINT `fk_user_order_orderid` FOREIGN KEY (`orderid`) REFERENCES `tc_orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_user_order_userid` FOREIGN KEY (`userid`) REFERENCES `tc_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `tc_user_order` */

/*Table structure for table `tc_user_report` */

DROP TABLE IF EXISTS `tc_user_report`;

CREATE TABLE `tc_user_report` (
  `userid` int NOT NULL,
  `reportid` int NOT NULL,
  KEY `fk_user_report_userid` (`userid`),
  KEY `fk_user_report_reportid` (`reportid`),
  CONSTRAINT `fk_user_report_reportid` FOREIGN KEY (`reportid`) REFERENCES `tc_reports` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_user_report_userid` FOREIGN KEY (`userid`) REFERENCES `tc_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `tc_user_report` */

/*Table structure for table `tc_user_user` */

DROP TABLE IF EXISTS `tc_user_user`;

CREATE TABLE `tc_user_user` (
  `userid` int NOT NULL,
  `manageduserid` int NOT NULL,
  KEY `fk_user_user_userid` (`userid`),
  KEY `fk_user_user_manageduserid` (`manageduserid`),
  CONSTRAINT `fk_user_user_manageduserid` FOREIGN KEY (`manageduserid`) REFERENCES `tc_users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_user_user_userid` FOREIGN KEY (`userid`) REFERENCES `tc_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `tc_user_user` */

/*Table structure for table `tc_users` */

DROP TABLE IF EXISTS `tc_users`;

CREATE TABLE `tc_users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `email` varchar(128) NOT NULL,
  `hashedpassword` varchar(128) DEFAULT NULL,
  `salt` varchar(128) DEFAULT NULL,
  `readonly` bit(1) NOT NULL DEFAULT b'0',
  `administrator` bit(1) DEFAULT NULL,
  `map` varchar(128) DEFAULT NULL,
  `latitude` double NOT NULL DEFAULT '0',
  `longitude` double NOT NULL DEFAULT '0',
  `zoom` int NOT NULL DEFAULT '0',
  `attributes` varchar(4000) DEFAULT NULL,
  `coordinateformat` varchar(128) DEFAULT NULL,
  `disabled` bit(1) DEFAULT b'0',
  `expirationtime` timestamp NULL DEFAULT NULL,
  `devicelimit` int DEFAULT '-1',
  `userlimit` int DEFAULT '0',
  `devicereadonly` bit(1) DEFAULT b'0',
  `phone` varchar(128) DEFAULT NULL,
  `limitcommands` bit(1) DEFAULT b'0',
  `login` varchar(128) DEFAULT NULL,
  `poilayer` varchar(512) DEFAULT NULL,
  `disablereports` bit(1) DEFAULT b'0',
  `fixedemail` bit(1) DEFAULT b'0',
  `totpkey` varchar(64) DEFAULT NULL,
  `temporary` bit(1) DEFAULT b'0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `idx_users_email` (`email`),
  KEY `idx_users_login` (`login`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `tc_users` */

insert  into `tc_users`(`id`,`name`,`email`,`hashedpassword`,`salt`,`readonly`,`administrator`,`map`,`latitude`,`longitude`,`zoom`,`attributes`,`coordinateformat`,`disabled`,`expirationtime`,`devicelimit`,`userlimit`,`devicereadonly`,`phone`,`limitcommands`,`login`,`poilayer`,`disablereports`,`fixedemail`,`totpkey`,`temporary`) values (1,'Admin','admin@traccar.com','A498FF295433835572CDA9951AC7BA7045C45CF4B1240921','E4AFB6E51DCEB04DFB4A9CFEA494FB6B652336B66955748A','\0','',NULL,0,0,0,'{\"laravel_password\":\"$2y$12$HJs2V6XslmiJBV\\/hceXfpe\\/\\/mClFBhEid\\/aOTdVqxE\\/Pf2OJo4jCy\",\"laravel_role\":\"super_admin\",\"laravel_status\":\"active\",\"laravel_country_code\":\"\",\"laravel_phone\":\"\",\"laravel_updated_at\":\"2026-05-27 04:58:52\"}',NULL,'\0',NULL,-1,-1,'\0',NULL,'\0','admin@traccar.com',NULL,'\0','\0',NULL,'\0'),(2,'Admin','admin@falconeyegps.com','1CD9BB3C8127849144108CBEA53BFC368304EF5BA499F659','6653AF84FD975DEB5A2E2F9F1609E5DFF91EA5AD752C452D','\0','',NULL,0,0,0,'{\"laravel_role\":\"super_admin\",\"laravel_status\":\"active\",\"laravel_password\":\"$2y$12$HciY4Pl4B1.J02VjTGlVSueAE9SMZNi0n5YZSpLgE1CQoOLwrz9VO\",\"laravel_preferences\":{\"locale\":\"ar\",\"map_tour\":\"dismiss\"},\"laravel_email_verified_at\":\"2026-05-23 17:53:21\",\"laravel_created_at\":\"2026-05-23 17:53:21\",\"laravel_remember_token\":\"cGsMwIbGy9KXteuulYkmlalk11xyUdZZSxyIqwXKzQkYmtm7fGhayer4Pp9w\",\"laravel_updated_at\":\"2026-06-05 03:07:10\"}',NULL,'\0',NULL,-1,-1,'\0',NULL,'\0','admin@falconeyegps.com',NULL,'\0','\0',NULL,'\0'),(5,'Falcon Eye GPS','company@falconeyegps.com','C191538924EA3715F71656D43A5EC8E9A4BAF500B8BDBD4B','AC2C07605F44D982D18707C7C225472671F1BF2CB8B7A1CC','\0','\0',NULL,0,0,0,'{\"laravel_role\":\"client\",\"laravel_status\":\"active\",\"laravel_country_code\":\"+92\",\"laravel_phone\":\"03003026824\",\"laravel_password\":\"$2y$12$lAvX3jjxyzsIJUUG83ZmIOF5aQK3KwOK8TD5mJQ.4bg.6WsqDHr\\/K\",\"laravel_updated_at\":\"2026-05-29 06:30:50\",\"laravel_created_at\":\"2026-05-29 06:30:50\",\"laravel_email_verified_at\":\"2026-05-29 06:30:50\",\"laravel_permissions\":{\"maps.view\":true}}',NULL,'\0',NULL,0,0,'\0',NULL,'\0','company@falconeyegps.com',NULL,'\0','\0',NULL,'\0'),(6,'Ali','ali@user.com','2E4848F02580E4560EA4B236E38461B92F5D5E945D71A0A7','4636A1A6F72598F08C96FBB27A4398D3A9D07C09F4BE50BF','\0','\0',NULL,0,0,0,'{\"laravel_role\":\"user\",\"laravel_status\":\"active\",\"laravel_country_code\":\"+92\",\"laravel_phone\":\"03003026824\",\"laravel_password\":\"$2y$12$Ue.FhDUKOstgAlcZziWzC.rawVvvByDWF3N9sAdyE.95PsFDntvCW\",\"laravel_updated_at\":\"2026-06-05 02:37:15\",\"laravel_created_at\":\"2026-05-29 06:32:20\",\"laravel_email_verified_at\":\"2026-05-29 06:32:20\",\"laravel_avatar\":\"avatars\\/6\\/avatar.jpg\",\"laravel_remember_token\":\"CI0xJpsC2ICbtZ5wFRad0FaNBpsbm2QwgOndcfZNl9cZvwjIGU4iQeYIPAgc\",\"laravel_preferences\":{\"map_tour\":\"dismiss\"}}',NULL,'\0',NULL,0,0,'\0',NULL,'\0','ali@user.com',NULL,'\0','\0',NULL,'\0'),(7,'V27','v27@gmail.com','944EBEBC575D0ABBAA4FA27AD8A485982F7452F123658102','B0509A724B488B1EB79AC2897A0D517F6554B38432AD5E14','\0','\0',NULL,0,0,0,'{\"laravel_role\":\"user\",\"laravel_status\":\"active\",\"laravel_country_code\":\"+92\",\"laravel_phone\":\"03312343433\",\"laravel_password\":\"$2y$12$QDyy.Rh3JWpay0GSAmqlv.4grdeh6cnwWoz6WciM9rXMoZKQ6TAia\",\"laravel_updated_at\":\"2026-05-30 01:50:37\",\"laravel_created_at\":\"2026-05-30 01:50:37\",\"laravel_email_verified_at\":\"2026-05-30 01:50:37\"}',NULL,'\0',NULL,0,0,'\0',NULL,'\0','v27@gmail.com',NULL,'\0','\0',NULL,'\0'),(8,'fdgfd dfgd','meltunutru@necub.com','BE2F95C7D3F36946E0471B5E26E9E95C5F55A05148F16665','EE92154E791F6982EE2EBF80A170689B4DE1293E8DBA8316','\0','\0',NULL,0,0,0,'{\"laravel_country_code\":\"+1\",\"laravel_phone\":\"18765324233\",\"laravel_password\":\"$2y$12$CUDxgUIhfVI2MvFxLf86fePnWkwQ2odf3HQ7tAJmzbvb3aMDKhBMi\",\"laravel_updated_at\":\"2026-05-30 15:45:48\",\"laravel_created_at\":\"2026-05-30 15:45:48\",\"laravel_email_verified_at\":\"2026-05-30 15:45:48\"}',NULL,'\0',NULL,0,0,'\0',NULL,'\0','meltunutru@necub.com',NULL,'\0','\0',NULL,'\0'),(9,'M Umar','mumar@user.com','0EB05AC8D1DADB60A5163907D57030830B18424BF9A9B102','1BDFAAA140ABE49A48EF5E5BBBD60ACA7FEE5F69B8EC9C52','\0','\0',NULL,0,0,0,'{\"laravel_role\":\"user\",\"laravel_status\":\"active\",\"laravel_country_code\":\"+92\",\"laravel_phone\":\"3003026824\",\"laravel_password\":\"$2y$12$BylIwAUpxJeluTy\\/DyG85ehi1BxicY7ajGN3WIBdQ9rspDsZ27Dde\",\"laravel_updated_at\":\"2026-06-05 15:23:54\",\"laravel_created_at\":\"2026-06-05 02:38:27\",\"laravel_email_verified_at\":\"2026-06-05 02:38:27\",\"laravel_remember_token\":\"DVhtsrXMmiDUUbhJfLXIMHQJNZ3TilBciCNW02XxBfgXyGmZMvJPcmvbKoZE\",\"laravel_preferences\":{\"map_tour\":\"dismiss\"}}',NULL,'\0',NULL,0,0,'\0',NULL,'\0','mumar@user.com',NULL,'\0','\0',NULL,'\0');

/*Table structure for table `user_push_tokens` */

DROP TABLE IF EXISTS `user_push_tokens`;

CREATE TABLE `user_push_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `fcm_token` varchar(512) COLLATE utf8mb4_unicode_ci NOT NULL,
  `platform` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'android',
  `device_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_seen_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_push_tokens_fcm_token_unique` (`fcm_token`),
  KEY `user_push_tokens_user_id_platform_index` (`user_id`,`platform`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `user_push_tokens` */

insert  into `user_push_tokens`(`id`,`user_id`,`fcm_token`,`platform`,`device_name`,`last_seen_at`,`created_at`,`updated_at`) values (2,3,'d8iMHExFQb2ocQLGW6fjb0:APA91bFzZooezJNcj1HCcgpX1gZ4ODlIjdjQthXFu2ogv_4rd9d7VlSajncZWOpy9qiYyt2Df2fPDbI8JaQ5M7GCH8TasDtSP_TOckvBcSFUL-A11aXKW0k','android','mobile-app','2026-05-29 04:38:32','2026-05-29 04:38:32','2026-05-29 04:38:32'),(4,3,'fy7fmFZ8T0ee3p89_jScm1:APA91bELypvWaCsKpJANJFdtiwpYhJX2LQyak6wikq521_-_vI6zCpZnD2HyB8yBIhfZlP6u1yNQ_tQ11YdAu-yia0kaY3nAD5qdVLMWZc-E5kQc2v-5L-s','android','mobile-app','2026-05-29 05:43:00','2026-05-29 05:39:07','2026-05-29 05:43:00'),(13,6,'dWzP1w9JRQGdtyS7_x5UeO:APA91bHx6LOBI15cSkR-oxs4D7gynDQV5zWH-_gaiiDPT6z7I5TN9SY4m1nJN2rCloyvVDfYAZ3qj28YkJD6LL4ZPGHTly976V52dzAmNiX4CrqKYlP0C4o','android','mobile-app','2026-05-31 02:33:46','2026-05-30 20:50:22','2026-05-31 02:33:46'),(15,6,'fXEMQYyERkeVBPj1HLWEvD:APA91bF_MoRqpXkmzaKFzu7ehYnVVzpPZU3aequV_W2df1KAuBLfDziSUv6pdpQLeMEY7Wm-FacUOvFUqMqmq6-h_zTxa74A4jk6wyOqIddtxRYDD7oKOO0','android','mobile-app','2026-06-01 12:10:25','2026-05-31 17:37:52','2026-06-01 12:10:25'),(17,6,'eWnCioaNSQWCfnRchq6giI:APA91bG68h287f8KyR5r4bVviVtzQeGNPUF0lu6GHSHbNPT2Vm67az0w2VAzY4gvQtypcfC9LPVHPzeT9NsJoH6gyQeWo60ojlRxVioi71iCzPVgZaOTb6E','android','mobile-app','2026-06-01 12:57:16','2026-06-01 12:20:24','2026-06-01 12:57:16'),(18,6,'ecR2j2z6Q36AuCOU7qSCVY:APA91bFiq40sVTV7REu0MHF4b0FtHb1q6pWN7KkuXsUamCgDqLGlY6g6u5jyeg42zUZg7fJsKu7q7kP_jGn2m4oDQfLBZevEgyf8coVUqSwCfYiodLYhSOo','android','mobile-app','2026-06-01 13:24:17','2026-06-01 13:13:28','2026-06-01 13:24:17'),(19,6,'fa3uQJHmQPyNJC8esuDT0t:APA91bFiq5oo-m7V1hWKHqdq_NmTGRWa35vy4QekqH3dOFMIWbia4nWAyrskAGF6nJLP_LNhskeiFauuQ3-thleoByaO3pYRUXzcwM7HyL4CMGdXlfTLI44','android','mobile-app','2026-06-01 13:38:26','2026-06-01 13:33:36','2026-06-01 13:38:26'),(21,6,'dADfTqHZRPaO_NKOQypFPb:APA91bE_wg-NZ6lZ87iZpdTINZiX2Z812tCsdnb3usZKDjWpl6npHeVeEOMTvWFCHIDDGC271W-kvaGoDzB5-FW2ZQezNRjka773YSaAdOHMznZbM8j1R1E','android','mobile-app','2026-06-02 00:28:27','2026-06-02 00:28:27','2026-06-02 00:28:27'),(22,6,'cT91GgtCTAGc8m1QMJ53VI:APA91bGTSzbFvqjsz6WW4fvUUij_qGOTkcGibwMX_1Vcybg6j1gdJfCBrU7S1G3QtsbgzpyFGPOrvTc1PHfcsQ_RBmSRU3wf-iTiSConFa7ost-9hILMbBI','android','mobile-app','2026-06-02 01:08:01','2026-06-02 01:08:01','2026-06-02 01:08:01'),(23,6,'dBBCGAIPSzu9IgM8ZGatmr:APA91bGGedeu0A11RpLCBibvy3nckopq_oqBN12TUpS8liCtqcZS7GuBTRd6iiK-wY6iVxQFDgTTyvyQiQEu5pXJl3Xwer9xL7gPaHbuN0eKhs8II81Ya10','android','mobile-app','2026-06-03 01:20:43','2026-06-02 13:30:04','2026-06-03 01:20:43'),(24,6,'fTyJehpYQoKRqOqsLoWYtG:APA91bEN0ye2Ag1iQb4j8I2im-QBey5BjBeJWQ4DV4KQDQYQrLuEcuJSAbAhZhyXOJRm26-N8r5VeFh_TyjjK4vLg_r4-ykJ_btb68s25vwfWU-L8K5Ihtc','android','mobile-app','2026-06-05 00:55:07','2026-06-03 12:09:43','2026-06-05 00:55:07'),(26,6,'d6vwnC3iSCOh_ix3Df8Jcf:APA91bHCVh6Zr5uNVnGYKzbXyonpJzmAtNosBjiSeQWSA-kzM63LVGBbkWVUUtx5r80VAYQJvM-k38bioVZta5krM1HdPEGOBGtSmyX5FnDf9py6Ac_YyFw','android','mobile-app','2026-06-03 22:40:31','2026-06-03 22:40:31','2026-06-03 22:40:31'),(29,9,'eYfaBNLQQh2HOiEzCMvWRP:APA91bGVNK_MB5yf4eIcU0FF_ssEXXTAbkOeldjpy9CcuxasGWbOzlQMduY_PoUtlAusq90k1xOwwUR1F2T7dwdleQ8IMDXN4QPOZsBvFbyx9otsBHJquJA','android','mobile-app','2026-06-05 15:28:23','2026-06-05 03:07:41','2026-06-05 15:28:23');

/*Table structure for table `vehicle_event_reads` */

DROP TABLE IF EXISTS `vehicle_event_reads`;

CREATE TABLE `vehicle_event_reads` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `vehicle_event_id` bigint unsigned NOT NULL,
  `read_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `vehicle_event_reads_user_id_vehicle_event_id_unique` (`user_id`,`vehicle_event_id`),
  KEY `vehicle_event_reads_user_id_read_at_index` (`user_id`,`read_at`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `vehicle_event_reads` */

insert  into `vehicle_event_reads`(`id`,`user_id`,`vehicle_event_id`,`read_at`) values (1,3,46,'2026-05-29 03:47:14'),(2,3,45,'2026-05-29 03:50:46'),(4,3,48,'2026-05-29 03:50:47'),(5,3,47,'2026-05-29 03:50:48'),(6,6,59,'2026-05-29 17:59:59'),(7,6,69,'2026-06-03 15:34:49'),(8,6,68,'2026-05-30 16:20:33'),(10,6,61,'2026-05-30 16:20:34'),(11,6,60,'2026-05-30 16:20:35'),(12,6,58,'2026-05-30 16:20:37'),(13,6,57,'2026-05-30 16:20:38'),(15,6,56,'2026-05-30 20:48:09'),(16,7,70,'2026-05-30 20:49:09'),(17,6,72,'2026-06-03 15:34:48'),(20,6,75,'2026-06-05 00:55:49');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
