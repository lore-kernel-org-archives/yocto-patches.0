Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web11.162656.1712741391823475924
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 10 Apr 2024 02:29:52 -0700
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-416a208d496so12020045e9.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 10 Apr 2024 02:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712741390; x=1713346190; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GLqh6+yinidPsXKL0OcYIWo7fnhcpEWrfUTNvkxflU8=;
        b=Fw5CJOsWGjlOjBi/eaF5vx3FmU8NUqv7lfxvvph2rzDjiwhzpNzZqSsC4LMotRkFLF
         t4eNB3KCpUPRpec9YhLxdzsoQ1r2whwdXJAGgL+y51E8hLgifRcRuLMalpc/2DxDem6F
         aJVKA21MJhIgIieByNnSQdPeJXoSzQMch46Tw=
Return-Path: <richard.purdie@linuxfoundation.org>
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
Subject: [PATCH 1/2] README: Switch to yocto-patches mailing list
Date: Wed, 10 Apr 2024 10:29:47 +0100
Message-Id: <20240410092948.1989389-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: yocto-patches@lists.yoctoproject.org
Cc: openembedded-core@lists.openembedded.org, seebs@seebs.net, mark.hatle@kernel.crashing.org
List-ID: <yocto-patches.lists.yoctoproject.org>

We're trying to align the various components so tweak pseudo to match our
other projects a little more and use the yocto-patches mailing list for
submissions.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 README | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/README b/README
index 468cf66..425ee6e 100644
--- a/README
+++ b/README
@@ -1,17 +1,9 @@
 pseudo -- an analogue to sudo
 
-IMPORTANT NOTE:
+The official home for pseudo's git repository is:
 
-As of this writing, the official home for pseudo's git repository has
-changed to:
 	git://git.yoctoproject.org/pseudo
 
-The old site at:
-	https://github.com/wrpseudo/pseudo
-
-is no longer the "real" master, although I'll probably try to keep it in
-sync.
-
 OVERVIEW:
 
 The pseudo utility offers a way to run commands in a virtualized "root"
@@ -88,7 +80,6 @@ available for other people to look at.
 
 CONTACT:
 
-Discussions and patches should be directed at the openembedded-core mailing
-list at openembedded-core at lists.openembedded.org. More information at
-https://www.openembedded.org/wiki/Mailing_lists. Bugs should be filed with
-the Yocto project at https://bugzilla.yoctoproject.org/.
+Patches should be directed at the yocto-patches mailing list at yocto-patches
+at lists.yoctoproject.org.  Bugs should be filed with the Yocto project
+at https://bugzilla.yoctoproject.org/.
-- 
2.40.1

