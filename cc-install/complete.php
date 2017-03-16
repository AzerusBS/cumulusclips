<?php

// Send user to appropriate step
if (!isset ($settings->completed)) {
    header ("Location: " . HOST . '/cc-install/');
    exit();
} else if (!in_array ('site-details', $settings->completed)) {
    header ("Location: " . HOST . '/cc-install/?site-details');
    exit();
}


// Establish needed vars.
$page_title = 'CumulusClips - Complete';
unset ($_SESSION['settings']);
$error_msg = null;


### Save provided information to the database
$pdo = new PDO('mysql:host=' . $settings->db_hostname . ';dbname=' . $settings->db_name, $settings->db_username, $settings->db_password, array(PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION));

// Save settings
$query = "INSERT INTO " . $settings->db_prefix . "settings (name, value) VALUES";
$query .= " ('base_url', '$settings->base_url'),";
$query .= " ('secret_key', '" . md5(time()) . "'),";
$query .= " ('sitename', '" . $settings->sitename . "'),";
$query .= " ('admin_email', '$settings->admin_email'),";
$query .= " ('enable_uploads', '$settings->uploads_enabled'),";
$query .= " ('ffmpeg', '$settings->ffmpeg'),";
$query .= " ('qtfaststart', '$settings->qtfaststart'),";
$query .= " ('php', '$settings->php')";
$result = $pdo->prepare($query)->execute();

// Save admin user
$query = "INSERT INTO " . $settings->db_prefix . "users (username, password, email, date_created, status, role, released) VALUES";
$query .= "('$settings->admin_username', '" . md5 ($settings->admin_password) . "', '$settings->admin_email', NOW(), 'active', 'admin', 1)";
$result = $pdo->prepare($query)->execute();
$id = $pdo->lastInsertId();

// Save admin user's privacy settings
$query = "INSERT INTO " . $settings->db_prefix . "privacy (user_id) VALUES ($id)";
$result = $pdo->prepare($query)->execute();

// Create admin user's favorites playlist
$query = "INSERT INTO " . $settings->db_prefix . "playlists (user_id, public, type, date_created) VALUES ($id, 0, 'favorites', NOW())";
$result = $pdo->prepare($query)->execute();

// Create admin user's watch later playlist
$query = "INSERT INTO " . $settings->db_prefix . "playlists (user_id, public, type, date_created) VALUES ($id, 0, 'watch_later', NOW())";
$result = $pdo->prepare($query)->execute();

// Log user into admin panel
$_SESSION['loggedInUserId'] = $id;
header ("Location: " . $settings->base_url . '/cc-admin/?first_run');