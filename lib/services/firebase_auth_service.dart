import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Stream to listen to auth state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Get current user
  User? get currentUser => _auth.currentUser;

  // ===== PHONE AUTHENTICATION =====
  
  /// Send OTP to phone number
  Future<void> verifyPhoneNumber(
    String phoneNumber, {
    required Function(String) onCodeSent,
    required Function(FirebaseAuthException) onError,
    required Function(String) onCodeAutoRetrievalTimeout,
  }) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Auto-verification (automatic)
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        onError(e);
      },
      codeSent: (String verificationId, int? resendToken) {
        onCodeSent(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        onCodeAutoRetrievalTimeout(verificationId);
      },
    );
  }

  /// Verify OTP code
  Future<UserCredential> verifyOTP(
    String verificationId,
    String smsCode,
  ) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      UserCredential userCredential = await _auth.signInWithCredential(credential);
      return userCredential;
    } catch (e) {
      rethrow;
    }
  }

  // ===== USER REGISTRATION =====
  
  /// Check if user exists in Firestore
  Future<bool> userExists(String uid) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();
      return doc.exists;
    } catch (e) {
      rethrow;
    }
  }

  /// Check if phone number is already registered
  Future<bool> phoneNumberExists(String phoneNumber) async {
    try {
      QuerySnapshot query = await _firestore
          .collection('users')
          .where('phoneNumber', isEqualTo: phoneNumber)
          .limit(1)
          .get();
      return query.docs.isNotEmpty;
    } catch (e) {
      rethrow;
    }
  }

  /// Save new user data to Firestore
  Future<void> saveUserData({
    required String uid,
    required String username,
    required String phoneNumber,
    required String email,
  }) async {
    try {
      await _firestore.collection('users').doc(uid).set({
        'uid': uid,
        'username': username,
        'phoneNumber': phoneNumber,
        'email': email,
        'createdAt': DateTime.now(),
        'updatedAt': DateTime.now(),
      });
    } catch (e) {
      rethrow;
    }
  }

  /// Get user data from Firestore
  Future<Map<String, dynamic>?> getUserData(String uid) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();
      return doc.data() as Map<String, dynamic>?;
    } catch (e) {
      rethrow;
    }
  }

  /// Update user data
  Future<void> updateUserData({
    required String uid,
    required Map<String, dynamic> data,
  }) async {
    try {
      await _firestore.collection('users').doc(uid).update({
        ...data,
        'updatedAt': DateTime.now(),
      });
    } catch (e) {
      rethrow;
    }
  }

  // ===== GOOGLE SIGN IN =====

  /// Sign in with Google (shows account picker only on first login)
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Try to get the previously signed-in account silently (no account picker)
      GoogleSignInAccount? googleUser = await _googleSignIn.signInSilently();
      
      // If no previous account, show account picker (first time only)
      if (googleUser == null) {
        googleUser = await _googleSignIn.signIn();
      }

      if (googleUser == null) {
        // User cancelled the sign-in
        return null;
      }

      // Obtain the auth details from the user
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Validate tokens
      if (googleAuth.accessToken == null) {
        throw Exception('Failed to obtain access token');
      }

      // Create a new credential using only accessToken
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the credential
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception('Firebase Error: ${e.code} - ${e.message}');
    } catch (e) {
      throw Exception('Google Sign-In failed: $e');
    }
  }

  // ===== SIGN OUT =====
  
  /// Sign out user (handles both phone and Google auth)
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } catch (e) {
      rethrow;
    }
  }
}
