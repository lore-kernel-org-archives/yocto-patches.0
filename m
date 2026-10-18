Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6B9CCF2C4
	for <webhook@archiver.kernel.org>; Sun, 18 Oct 2026 01:56:46 +0000 (UTC)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7946.1792288597431683007
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 17 Oct 2026 18:56:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=HY4b0DoV;
 spf=pass (domain: gmail.com, ip: 209.85.216.44, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3acb11973c3so1032468a91.3
        for <yocto-patches@lists.yoctoproject.org>; Sat, 17 Oct 2026 18:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792288597; x=1792893397; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/dqqWpOFpXPT2eU+jHz05dzVBinWcGG25VQxOgnCqhA=;
        b=HY4b0DoVaWdwmOP+ZTaKFwcM89U7T2skcM6GHuHjoGEqIq8PGPwkv5YADdB2MzxIDK
         ZjOCeY0cttfr9TfjkZP0mpdGmKGHKIMcidKRZ8Q+IUeiyZED+AJipmXwMgfjmB5NWweq
         EPeDfrhZcoatAlSgkX97EWFRXZ5oe7akuGPmB9pJvM/GOSwK7X7PPuEAOjTFm7Z+0Ldm
         aNnSZtI9YChh4PcosVGu6diXhAN+xg7DizbHjRTLPQE+djTKNLsZaBh+DDkwmhh0ZU+r
         YrwtBJHdr00dEyLbv7iO9HSRaVHrYYbVufC/clJbRVP0yeL/BSOEjfcsBVACkHIa4p5r
         Nxrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792288597; x=1792893397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/dqqWpOFpXPT2eU+jHz05dzVBinWcGG25VQxOgnCqhA=;
        b=PQRLD2AbuOqI9bpjxmMYxmQSRR/gwT4NXdpSP9fzEDOWzPLWz/RakBB2TFQQFQP/8Q
         ki8zuA8k3VFzIJ1EeFbKAQK1mJrHc+Yypl07En75QBHi0SlufHfipLHBVUmqzXUE3BG3
         s3B5k0KhgR2ChIshemh+1KocyqA+lowNI9itegDS8RHWJzJHc8peyZENIdsP+cmiEuUA
         Sz7fvTpJfHm4ycYIGA0UtOppr98dl34DAQ+pLywzd5x3LspBSWRvSrpV4FEDw3DGq+7o
         oVDEncsYq01D+WKoYRsZcvb/t9ka2M8LdF2g6PA6il3kCbl55VFOsZduJQnNlv0uzj/V
         Slow==
X-Gm-Message-State: AFq9FYKwKF6EU0cpuAqVzrsiWUXgl31UCd6HsckDpSrD0YkaaVQkf660
	EyPEUemilnPaj+q/LkxpbrF+ARr0BaFkI1/YZaup/1FF6bWSLKnQXhrCp+SDdw==
X-Gm-Gg: AYBFou1OQEyvAnip9X/kTwrcRHljd7OJuFKd2s7rG4Rh5x/1KbvTVRqizetl4RCMhhi
	afu8+nufPYnJCzUtVzfkvNQivyZerCcQlBI+1lUKt/1bg4Kkg0LE0tkPSiPABB0kq03AUAUxH0n
	O3L6l3RRbhIyI2HWD8cVxmHuSAg7ISnbEgeYnlqMr1k8U8464+x+ysMDae/LxHxB8BT9W4sbe2F
	h+tuxo8zjyy/PR16O1OOeg2SiTPZiWyzLNPZyWipOfXg0/Mz1bpoy2P3FyLmUHv5Wiy+6ggwyLG
	FRwiCuT1o0uz1dCqUMytRBgDkIBz9metIZaUxIE2VjYRVaFFfKONdsejgBRnWUh8RTw7BOx1oQX
	PuZXoT/Z//VZeYKk0xvbNkjQQcy6YE02GZmaDclCGTZczZWUfm8BeBs7cK9Orpz0rOVG6IAyd4S
	2tCcED5SRaHZMlvNhim+xJNdFlGOUeIRVp+TrdFKAIX3LDoDKdAi8eXqjcnPHM/SU1xSTzNjxn3
	q0yEOXcMyZdbkiOoiR62ayVi7otqKw=
X-Received: by 2002:a17:90b:380b:b0:3ab:413:49b1 with SMTP id 98e67ed59e1d1-3aceefb87eemr3428952a91.48.1792288596663;
        Sat, 17 Oct 2026 18:56:36 -0700 (PDT)
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acd05fb680sm6135920a91.2.2026.10.17.18.56.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 17 Oct 2026 18:56:34 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [error-report-web][PATCH 1/2] Enable SecurityMiddleware and XFrameOptionsMiddleware.
Date: Sat, 17 Oct 2026 18:54:38 -0700
Message-ID: <20261018015615.74684-3-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018015615.74684-1-tim.orling@konsulko.com>
References: <20261018015615.74684-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 01:56:46 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5059

Fixes check --deploy W001 and W002: adds nosniff, Referrer-Policy,
Cross-Origin-Opener-Policy and X-Frame-Options: DENY. Use Django's
middleware order, which drops a duplicate SessionMiddleware.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 Post/test.py               | 6 ++++++
 project/settings.py        | 7 +++----
 project/settings.py.docker | 7 +++----
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/Post/test.py b/Post/test.py
index 77adc32..28982e4 100755
--- a/Post/test.py
+++ b/Post/test.py
@@ -267,6 +267,12 @@ class CSPTest(TestCase):
             self.assertNotIn("unsafe-inline", csp)
             self.assertNotIn("unsafe-eval", csp)
 
+    def test_security_headers(self):
+        response = self.client.get('/Statistics/')
+        self.assertEqual(response['X-Frame-Options'], 'DENY')
+        self.assertEqual(response['X-Content-Type-Options'], 'nosniff')
+        self.assertEqual(response['Referrer-Policy'], 'same-origin')
+
     def test_csp_report_only(self):
         with override_settings(CONTENT_SECURITY_POLICY_REPORT_ONLY=True):
             # New client so the middleware picks up the setting
diff --git a/project/settings.py b/project/settings.py
index 28e526b..97c179c 100644
--- a/project/settings.py
+++ b/project/settings.py
@@ -132,15 +132,14 @@ STATICFILES_FINDERS = (
 SECRET_KEY = 'changeme'
 
 MIDDLEWARE = [
-    'django.middleware.common.CommonMiddleware',
+    'django.middleware.security.SecurityMiddleware',
     'django.contrib.sessions.middleware.SessionMiddleware',
+    'django.middleware.common.CommonMiddleware',
     'django.middleware.csrf.CsrfViewMiddleware',
-    'django.contrib.sessions.middleware.SessionMiddleware',
     'django.contrib.auth.middleware.AuthenticationMiddleware',
     'django.contrib.messages.middleware.MessageMiddleware',
+    'django.middleware.clickjacking.XFrameOptionsMiddleware',
     'Post.middleware.ContentSecurityPolicyMiddleware',
-    # Uncomment the next line for simple clickjacking protection:
-    # 'django.middleware.clickjacking.XFrameOptionsMiddleware',
 ]
 
 ROOT_URLCONF = 'project.urls'
diff --git a/project/settings.py.docker b/project/settings.py.docker
index bce1347..70c9253 100644
--- a/project/settings.py.docker
+++ b/project/settings.py.docker
@@ -126,15 +126,14 @@ STATICFILES_FINDERS = (
 SECRET_KEY = os.environ.get('SECRET_KEY', 'changeme')
 
 MIDDLEWARE = [
-    'django.middleware.common.CommonMiddleware',
+    'django.middleware.security.SecurityMiddleware',
     'django.contrib.sessions.middleware.SessionMiddleware',
+    'django.middleware.common.CommonMiddleware',
     'django.middleware.csrf.CsrfViewMiddleware',
-    'django.contrib.sessions.middleware.SessionMiddleware',
     'django.contrib.auth.middleware.AuthenticationMiddleware',
     'django.contrib.messages.middleware.MessageMiddleware',
+    'django.middleware.clickjacking.XFrameOptionsMiddleware',
     'Post.middleware.ContentSecurityPolicyMiddleware',
-    # Uncomment the next line for simple clickjacking protection:
-    # 'django.middleware.clickjacking.XFrameOptionsMiddleware',
 ]
 
 ROOT_URLCONF = 'project.urls'
-- 
2.56.0


