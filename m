Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068D9C282D2
	for <webhook@archiver.kernel.org>; Tue,  4 Mar 2025 15:18:56 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web10.24142.1741101529084374306
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 04 Mar 2025 07:18:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=BMEvrnxk;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43948021a45so52912285e9.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 04 Mar 2025 07:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741101526; x=1741706326; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qQOb6oAcBkQMPI7XbLgqiG4sy3/IxceLQtXtWPvyGUs=;
        b=BMEvrnxkREk2bWkN5/Q3YkQWPvsxmdfC7Hqf4RdboQljm0UqeBnTPaK8cy+4nasa8i
         zy4ge/I2BLkFjp1QQbLxntTJlHMK6aKPbmoel+PaInbhMlglRFB+uG/Jf3A8Yks5sxrs
         8wIctw3/KMmA+I2pyaiDAhKx0HWBb0AiPCZFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741101526; x=1741706326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qQOb6oAcBkQMPI7XbLgqiG4sy3/IxceLQtXtWPvyGUs=;
        b=eXWc0S1j2fwxgAJ285Cv/ZQQkpgFXDxOs1Yr8pMLoKjEAEyKhi8ccLMIc7xJ0znUPM
         RlgWeIVjuNFu77I2laHCFF1lHdTQUVP3mS4+K7QDHCR9xDxipxbGXdOvLslx2BJUAV2b
         3aisIq/iTOh03k0KrGXT6/FRDcfsursIsLsmeN6YuZF4gBXFFewQv/4zXa3E2zq1IFui
         eufCX6VHSvubtEFNJGmvswDT25PjpK9GRfFYuUFJLYyU4ayKJcCT25KHnpZUrO5MRfj9
         WEL4KHPs1CbrYbVgCQOQxreIPxbJDyU0lCFFT8retQXFbnNP2/+VMS65xqwqYOriJbgU
         I3ZA==
X-Gm-Message-State: AOJu0YzlDCMcGrGLDzscrTCTF4qH+2kCmnc+jVW1xW7O2ksiQ0In3FhK
	r3LlNnb2oUqN16DAgn50BjUDeiZyIRnsKbPzxSG8ZVjt8Pd+/ARFkexnoThoZEAnGw3BlSv/2Iz
	f
X-Gm-Gg: ASbGncvxZXyzipHr5VbphQih7ZSphgMGKukm0gghbgg7R+sqfR9bXdZTTBZBpCEecx2
	XeBY9h6qdt4thXpHWEx+UHuJ71W1g4CF78RWvlMxZfSHP5OSxHQ+zwsxH3JX+M/ddh+426XQjM/
	wfdpFZ6ivlBG/nL3bz6OBuoMrT+4z0U+bh3uOir8eYaE2BFkKeqVcsEc9HDRFz0KCaM7aIbOQVI
	nNvcq28Ol+c/HC5/6NRDdP6njVo9nKLUnC3t2u0e8rd+QLrQuDCfN2RbzzQPL16WXZ6Gy9HLufR
	eszinLrOpYIBQ/yZCYxGZD/i/cr1ydlEcSVeeb5/BpL8jQcqfu54SKGxSKaJmR80jKzfw6B86Q=
	=
X-Google-Smtp-Source: AGHT+IFabE/ZsYtPAgRrODUUoakrGTwfAjLRrMOT/U2VMunxcuj2WZCetHbX3FZn+d+il62iEhSnwg==
X-Received: by 2002:a05:600c:44d6:b0:43b:c0fa:f9c9 with SMTP id 5b1f17b1804b1-43bc0fb002cmr74751355e9.7.1741101526358;
        Tue, 04 Mar 2025 07:18:46 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:bea3:48e1:f1c0:6abe])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bc596eb90sm60738905e9.17.2025.03.04.07.18.45
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 07:18:45 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH] scripts/yocto-supported-distros: Better integrate for autobuilder use
Date: Tue,  4 Mar 2025 15:18:44 +0000
Message-ID: <20250304151844.1930074-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 04 Mar 2025 15:18:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1140

For autobuilder use, it will be more helpful to print warnings for the issues found
which will show up in the autobuilder UI in this format. We can then save the error
exit code for actual script failures which should improve usability from the autobuilder
perspective.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 scripts/yocto-supported-distros | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/scripts/yocto-supported-distros b/scripts/yocto-supported-distros
index da5399d..e0550eb 100755
--- a/scripts/yocto-supported-distros
+++ b/scripts/yocto-supported-distros
@@ -107,6 +107,14 @@ def _print_worker_list(worker_list: List, indent=2):
         print(" " * indent + w)
 
 
+def _print_worker_list_warning(worker_list: List, warning):
+    """
+    Helper to print a set nicely.
+    """
+    for w in worker_list:
+        print("WARNING: " + warning + ": " + w)
+
+
 def _print_workers(possible_workers: Dict[str, List]):
     """
     Helper to print the workers nicely.
@@ -204,15 +212,13 @@ def _compare(ab_workers: set, poky_workers: set):
 
     poky_missing = ab_workers.difference(sorted(list(poky_workers)))
     if poky_missing:
-        print("Missing in poky.conf but configured on the autobuilder:")
-        _print_worker_list(poky_missing)
+        _print_worker_list_warning(poky_missing, "Missing in poky.conf but configured on the autobuilder")
         print()
         ok = False
 
     ab_missing = poky_workers.difference(sorted(list(ab_workers)))
     if ab_missing:
-        print("Missing on the autobuilder but listed in poky.conf:")
-        _print_worker_list(sorted(list(ab_missing)))
+        _print_worker_list_warning(sorted(list(ab_missing)), "Missing on the autobuilder but listed in poky.conf")
         print()
         ok = False
 
@@ -286,8 +292,7 @@ def main():
                 ab_workers.add(mangled_w)
 
         if not _compare(ab_workers, poky_workers):
-            print("Errors were found")
-            exit(1)
+            print("Mismatches were found")
         else:
             print("All good!")
 

