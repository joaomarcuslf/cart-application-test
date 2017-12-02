# Be sure to restart your server when you modify this file.

# Specify a serializer for the signed and encrypted cookie jars.
# Valid options are :json, :marshal, and :hybrid.
CartApplicationTest::Application.config.session_store :cookie_store,
  :key => '_cart_application_session',
  :expire_after =>  2.days
