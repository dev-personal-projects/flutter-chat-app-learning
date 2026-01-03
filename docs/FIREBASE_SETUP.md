# 🔥 Firebase Setup Guide

This guide covers Firebase configuration and troubleshooting for the chat app.

## Firebase Authentication Setup

### Supported Sign-in Methods (Current App Flow)

The app currently supports these sign-in methods:

- **Phone (OTP)**: WhatsApp-style phone verification (may require billing)
- **Email/Password**: Works without billing
- **Google OAuth**: Works without billing (requires SHA setup)

The unauthenticated entry screen is **SignInPage** (Phone / Email / Google).

### Enabling Phone Authentication

If you see this error:

```
This operation is not allowed. This may be because the given sign-in provider is disabled for this Firebase project.
```

**Solution:**

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select your project
3. Navigate to **Authentication** → **Sign-in method**
4. Find **Phone** in the list of providers
5. Click on **Phone** to enable it
6. Toggle **Enable** to ON
7. Click **Save**

### Configuring reCAPTCHA (Optional but Recommended)

If you see this warning:

```
Failed to initialize reCAPTCHA config: No Recaptcha Enterprise siteKey configured
```

**Note:** This is a warning, not an error. Phone authentication will still work, but reCAPTCHA provides additional security.

**To enable reCAPTCHA:**

1. In Firebase Console → **Authentication** → **Sign-in method** → **Phone**
2. Under **reCAPTCHA verification**, you can configure:
   - **reCAPTCHA Enterprise** (recommended for production)
   - Or use the default reCAPTCHA v3

### Enabling Billing (REQUIRED for Phone Authentication)

**⚠️ IMPORTANT:** Phone Authentication **requires billing to be enabled** in Firebase, even for development/testing.

If you see this error:

```
An internal error has occurred. [BILLING_NOT_ENABLED]
```

**Solution:**

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select your project
3. Click on the **⚙️ Settings (gear icon)** → **Usage and billing**
4. Click **Upgrade project** or **Manage billing**
5. Add a payment method (credit/debit card)
6. **Note:** Firebase has a free tier (Spark plan) that includes:
   - 10,000 phone authentications per month (free)
   - No credit card required for Spark plan, but billing account may be needed
7. For Blaze plan (pay-as-you-go):
   - First 10,000 verifications/month are free
   - After that, very low cost per verification
   - You only pay for what you use beyond the free tier

**Important Notes:**

- Billing must be enabled even if you stay within free tier
- You won't be charged if you stay within free limits
- Phone authentication won't work without billing enabled

### Testing Phone Authentication

**Important:** Phone authentication requires:

- A real phone number
- SMS delivery (test numbers may not work)
- **Billing enabled in Firebase project** (REQUIRED)

**For Development:**

- Use test phone numbers if available in your region
- Check Firebase Console → Authentication → Users to see verification attempts
- Ensure billing is enabled even for testing

## Common Firebase Errors

### Error Code: 17006

**Message:** "This operation is not allowed"

**Causes:**

- Phone authentication not enabled
- Project doesn't have billing enabled
- Phone number format incorrect

**Solutions:**

1. Enable Phone authentication in Firebase Console
2. **Enable billing in Firebase Console** (Settings → Usage and billing)
3. Ensure phone number is in E.164 format (+1234567890)

### Error: BILLING_NOT_ENABLED

**Message:** "An internal error has occurred. [BILLING_NOT_ENABLED]"

**Cause:**

- Firebase billing is not enabled for your project
- Phone Authentication requires billing to be enabled

**Solution:**

1. Go to Firebase Console → Your Project
2. Click **⚙️ Settings** → **Usage and billing**
3. Click **Upgrade project** or **Manage billing**
4. Add a payment method
5. Choose **Blaze plan** (pay-as-you-go) or ensure billing account is set up
6. **Note:** You won't be charged for the first 10,000 verifications/month (free tier)

**Important:** This is a **required step** - Phone Authentication will not work without billing enabled, even for development/testing.

### Error Code: 17020

**Message:** "Invalid phone number format"

**Solution:**

- Ensure phone number is in E.164 format
- Include country code (e.g., +254 for Kenya)
- Remove spaces, dashes, parentheses

### Error Code: 17026

**Message:** "Invalid verification code"

**Causes:**

- Code expired (usually expires after 60 seconds)
- Wrong code entered
- Code already used

**Solution:**

- Request a new code
- Enter code within 60 seconds
- Double-check the code from SMS

## Firebase Project Configuration

### Android Configuration

1. **Download `google-services.json`**

   - Firebase Console → Project Settings → Your apps → Android app
   - Download `google-services.json`
   - Place in `android/app/` directory

2. **Update `build.gradle`**
   - Ensure `google-services` plugin is added
   - Check `android/build.gradle` and `android/app/build.gradle`

### iOS Configuration

1. **Download `GoogleService-Info.plist`**

   - Firebase Console → Project Settings → Your apps → iOS app
   - Download `GoogleService-Info.plist`
   - Add to Xcode project

2. **Update `Info.plist`**
   - Add required permissions and configurations

## Troubleshooting

### Phone Number Not Receiving SMS

**Possible causes:**

1. Phone authentication not enabled
2. Invalid phone number format
3. Network issues
4. Firebase quota exceeded
5. Phone number not supported in your region

**Solutions:**

1. Verify phone authentication is enabled
2. Check phone number format (E.164)
3. Test with different phone numbers
4. Check Firebase Console for quota limits
5. Enable test phone numbers if available

### Verification Code Not Working

**Possible causes:**

1. Code expired (60-second timeout)
2. Wrong code entered
3. Code already used
4. Network issues

**Solutions:**

1. Request a new code
2. Enter code quickly after receiving
3. Double-check the code
4. Ensure stable internet connection

## Best Practices

1. **Always enable Phone authentication** before testing
2. **Use E.164 format** for phone numbers (+country code + number)
3. **Handle errors gracefully** - show user-friendly messages
4. **Implement resend functionality** with cooldown timer
5. **Test on real devices** - emulators may have limitations
6. **Monitor Firebase Console** for authentication attempts and errors

## Testing Checklist

- [ ] Phone authentication enabled in Firebase Console
- [ ] `google-services.json` properly configured
- [ ] Phone number in E.164 format
- [ ] Error handling implemented
- [ ] Resend OTP functionality working
- [ ] Tested on real device
- [ ] SMS received successfully
- [ ] OTP verification working

### Email/Password Authentication (No Billing Required)

1. Firebase Console → **Authentication** → **Sign-in method**
2. Enable **Email/Password**
3. Save

**Notes:**

- Email/password is a great fallback when phone billing is blocked.
- Make sure you’ve added your Android app to the Firebase project and downloaded `google-services.json`.

### Google Sign-In (OAuth) Setup (Recommended Fallback)

#### 1) Enable provider

1. Firebase Console → **Authentication** → **Sign-in method**
2. Enable **Google**
3. Set a project support email
4. Save

#### 2) Add SHA fingerprints (Android)

If you don’t add SHA-1, Google sign-in typically fails with “developer error” / `ApiException: 10`.

Get debug SHA-1:

```bash
cd android
./gradlew signingReport
```

Then in Firebase Console:

1. **Project Settings** → **Your apps** → Android app
2. Add **SHA-1** (and **SHA-256** if possible)
3. Save

Repeat for your **release** keystore later (production builds).

#### 3) Download fresh config

1. Firebase Console → **Project Settings** → **Your apps** → Android
2. Download updated `google-services.json`
3. Replace: `android/app/google-services.json`

#### 4) Verify

```bash
flutter clean
flutter pub get
flutter run
```

### When Billing Isn’t Available

If you cannot create a billing account right now:

- Use **Email/Password** and/or **Google** sign-in (recommended).
- For phone flows, consider **Firebase test phone numbers** in:
  Firebase Console → Authentication → Sign-in method → Phone → “Phone numbers for testing”.

---

**Note:** For production apps, ensure billing is enabled and consider implementing reCAPTCHA for additional security.
