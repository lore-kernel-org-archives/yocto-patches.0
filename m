Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
 by mx.groups.io with SMTP id smtpd.web11.140303.1712676748127704196
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 09 Apr 2024 08:32:28 -0700
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-617d411a6b3so35552937b3.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 09 Apr 2024 08:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712676747; x=1713281547; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6cyVJemPbWOHRBPrNb3oALIjcqQ5fC8VBGDtsk2paT0=;
        b=L/fcs3QDd4PnQhV61WUnEfKA5KYYnhOLYgTAEXcnuDbu0A6olsP+gPP+pQl9ZRsZFG
         39F6HReNweE9OUVhO2aloqikiU5mnDWgiytOAG8t59Xqc7UJnKGTp+hbADWl4dKbJyHB
         /nDhvtJIeFSjtUZflqAb5OcuOShb3zL7Pa7euKBRVaUeWpVjW7LD6vem6SBHWlmXp2ug
         Em6lYx45u92Eq/hVHLF/Jm65SxdnDXR56JBHuIF2HflHMZzRgDrKE6jdyzYWd9EMOQM1
         4cYZf34u8BK4B2TrHj9DKay1fC8ByOB4oBMElZnuvQV7S7sXijw2NPu+8jy3KwpMxLxc
         LMuA==
Return-Path: <akuster808@gmail.com>
Received: from keaua.attlocal.net ([2600:1700:45dd:7000:b5f6:d6b7:e4bc:9034])
        by smtp.gmail.com with ESMTPSA id dc13-20020a05690c0f0d00b0060a046c50f1sm2223380ywb.58.2024.04.09.08.32.26
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 08:32:26 -0700 (PDT)
From: "Armin Kuster" <akuster808@gmail.com>
Subject: [meta-security][PATCH] README.md: update to new patches mailing list
Date: Tue,  9 Apr 2024 11:32:25 -0400
Message-Id: <20240409153225.118062-1-akuster808@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: yocto-patches@lists.yoctoproject.org
List-ID: <yocto-patches.lists.yoctoproject.org>

Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 README.md                | 4 ++--
 meta-hardening/README.md | 6 +++---
 meta-integrity/README.md | 2 +-
 meta-parsec/README.md    | 6 +++---
 meta-tpm/README.md       | 6 +++---
 5 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/README.md b/README.md
index 2d1996b..3e092a9 100644
--- a/README.md
+++ b/README.md
@@ -69,10 +69,10 @@ This will activate the dynamic-layer mechanism.
 Maintenance
 ======================================
 
-Send pull requests, patches, comments or questions to yocto@lists.yoctoproject.org
+Send pull requests, patches, comments or questions to yocto-patches@lists.yoctoproject.org  
 
 When sending single patches, please using something like:
-'git send-email -1 --to yocto@lists.yoctoproject.org --subject-prefix=meta-security][PATCH'
+'git send-email -1 --to yocto-patches@lists.yoctoproject.org --subject-prefix=meta-security][PATCH'
 
 These values can be set as defaults for this repository:
 
diff --git a/meta-hardening/README.md b/meta-hardening/README.md
index 191253c..cc39ca4 100644
--- a/meta-hardening/README.md
+++ b/meta-hardening/README.md
@@ -64,14 +64,14 @@ layers: meta-oe
 Maintenance
 -----------
 
-Send pull requests, patches, comments or questions to yocto@lists.yoctoproject.org
+Send pull requests, patches, comments or questions to yocto-patches@lists.yoctoproject.org
 
 When sending single patches, please using something like:
-'git send-email -1 --to yocto@lists.yoctoproject.org --subject-prefix=meta-hardening][PATCH'
+'git send-email -1 --to yocto-patches@lists.yoctoproject.org --subject-prefix=meta-hardening][PATCH'
 
 These values can be set as defaults for this repository:
 
-$ git config sendemail.to yocto@lists.yoctoproject.org
+$ git config sendemail.to yocto-patches@lists.yoctoproject.org
 $ git config format.subjectPrefix meta-hardening][PATCH
 
 Now you can just do 'git send-email origin/master' to send all local patches.
diff --git a/meta-integrity/README.md b/meta-integrity/README.md
index 2f30e78..c333a9f 100644
--- a/meta-integrity/README.md
+++ b/meta-integrity/README.md
@@ -41,7 +41,7 @@ Patches
 =======
 
 For discussion or patch submission via email, use the
-yocto@yoctoproject.org mailing list. When submitting patches that way,
+yocto-patches@yoctoproject.org mailing list. When submitting patches that way,
 make sure to copy the maintainer and add a "[meta-integrity]"
 prefix to the subject of the mails.
 
diff --git a/meta-parsec/README.md b/meta-parsec/README.md
index 9b231f6..785c932 100644
--- a/meta-parsec/README.md
+++ b/meta-parsec/README.md
@@ -244,14 +244,14 @@ systemctl start parsec
 Maintenance
 -----------
 
-Send pull requests, patches, comments or questions to yocto@yoctoproject.org
+Send pull requests, patches, comments or questions to yocto-patches@lists.yoctoproject.org
 
 When sending single patches, please using something like:
-'git send-email -1 --to yocto@lists.yoctoproject.org --subject-prefix=meta-parsec][PATCH'
+'git send-email -1 --to yocto-patches@lists.yoctoproject.org --subject-prefix=meta-parsec][PATCH'
 
 These values can be set as defaults for this repository:
 
-$ git config sendemail.to yocto@lists.yoctoproject.org
+$ git config sendemail.to yocto-patches@lists.yoctoproject.org
 $ git config format.subjectPrefix meta-parsec][PATCH
 
 Now you can just do 'git send-email origin/master' to send all local patches.
diff --git a/meta-tpm/README.md b/meta-tpm/README.md
index 5722a92..983c753 100644
--- a/meta-tpm/README.md
+++ b/meta-tpm/README.md
@@ -57,14 +57,14 @@ other layers needed. e.g.:
 Maintenance
 -----------
 
-Send pull requests, patches, comments or questions to yocto@lists.yoctoproject.org
+Send pull requests, patches, comments or questions to yocto-patches@lists.yoctoproject.org  
 
 When sending single patches, please using something like:
-'git send-email -1 --to yocto@lists.yoctoproject.org --subject-prefix=meta-security][PATCH'
+'git send-email -1 --to yocto-patches@lists.yoctoproject.org --subject-prefix=meta-security][PATCH'
 
 These values can be set as defaults for this repository:
 
-$ git config sendemail.to yocto@lists.yoctoproject.org
+$ git config sendemail.to yocto-patches@lists.yoctoproject.org
 $ git config format.subjectPrefix meta-security][PATCH
 
 Now you can just do 'git send-email origin/master' to send all local patches.
-- 
2.34.1

