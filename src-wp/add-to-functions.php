function v_getUrl() {
  $url  = @( $_SERVER["HTTPS"] != 'on' ) ? 'http://'.$_SERVER["SERVER_NAME"] : 'https://'.$_SERVER["SERVER_NAME"];
  $url .= $_SERVER["REQUEST_URI"];
  return $url;
}
function v_forcelogin() {
  if( !is_user_logged_in() && ( v_getUrl() != wp_login_url() && v_getUrl() != wp_registration_url() && v_getUrl() != wp_lostpassword_url() ) ) {
    wp_redirect( wp_login_url(), 302 );
    exit();
  }
}
add_action('init', 'v_forcelogin');