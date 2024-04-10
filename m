Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
 by mx.groups.io with SMTP id smtpd.web10.7627.1712770215533182283
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 10 Apr 2024 10:30:15 -0700
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-516d09bd434so7763248e87.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 10 Apr 2024 10:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712770213; x=1713375013; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IoYaBCbaO/8vl2D4luf6imCyiO/B62d/ZivxsgQvfLY=;
        b=ANypigN/vk9RJ07UIgTRY0ujWm5AGSd/uK2tSCplpr5l+aTklrdHshqlW9c89x2YmX
         CEehGUDLmI+unA++zAwcK1iZexKBnk6JBjVIdFbfF0OnJlvV73eXgFrjUD3G9u8gZ+Qf
         8Q+djF2q1wY+YGTsVQ8GZ3wRJuot+hNOcPhls=
Return-Path: <richard.purdie@linuxfoundation.org>
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
Subject: [PATCH] README: Further improve the information about sending patches
Date: Wed, 10 Apr 2024 18:30:12 +0100
Message-Id: <20240410173012.2051694-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net, mark.hatle@kernel.crashing.org
List-ID: <yocto-patches.lists.yoctoproject.org>

Add the git config commands needed to correctly/more easily send patches.

Also tweak the description and mention who the current nominal maintainers
are.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 README | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/README b/README
index 425ee6e..c4cb997 100644
--- a/README
+++ b/README
@@ -1,8 +1,8 @@
-pseudo -- an analogue to sudo
+pseudo -- an analogue to sudo and an alternative to fakeroot
 
 The official home for pseudo's git repository is:
 
-	git://git.yoctoproject.org/pseudo
+	https://git.yoctoproject.org/pseudo
 
 OVERVIEW:
 
@@ -70,6 +70,7 @@ commentary.
 
 ACKNOWLEDGEMENTS:
 
+Peter Seebach:
 My various coworkers, both engineering and management, made this possible.
 While I did most of the actual typing, this code has benefitted greatly
 from detailed code reviews, excellent reproducers for bugs, and the
@@ -78,8 +79,19 @@ deal of fun, and I'm pretty happy that we're finally ready to make it
 available for other people to look at.
 
 
+MAINTAINERS:
+
+Richard Purdie
+Mark Hatle
+
+
 CONTACT:
 
 Patches should be directed at the yocto-patches mailing list at yocto-patches
-at lists.yoctoproject.org.  Bugs should be filed with the Yocto project
-at https://bugzilla.yoctoproject.org/.
+at lists.yoctoproject.org with [pseudo] in the subject line.  Bugs should be
+filed with the Yocto project at https://bugzilla.yoctoproject.org/.
+
+The repository can be configured to do this correctly with:
+
+  git config format.subjectprefix "pseudo] [PATCH"
+  git config sendemail.to yocto-patches@lists.yoctoproject.org
-- 
2.40.1

