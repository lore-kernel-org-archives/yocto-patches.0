Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AEAC44501
	for <webhook@archiver.kernel.org>; Wed,  1 Jul 2026 13:13:52 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.44678.1782911628739097363
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 01 Jul 2026 06:13:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=NKitCg/U;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4759b4f0897so497121f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 01 Jul 2026 06:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1782911627; x=1783516427; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w1+SRdj20u5uV7luAfrwrs55sSE1VKgdD+9XdW4V9II=;
        b=NKitCg/UKyzoKqOojiBZFwF23U+QtOvwaSGw7WDPA2jZz/Dv39ukp6al4lmbZTuz2/
         VKljFH8MnvtSTf3BqcfemWrWLbsCz7P1pXkYiz1eFZEYuc2aLq/qiROSsIihl+wKeNKW
         OWWjzLjQb9+V5xGqnxLaZNEng/6u6QoTSw2H0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782911627; x=1783516427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w1+SRdj20u5uV7luAfrwrs55sSE1VKgdD+9XdW4V9II=;
        b=cRK8ALE0sWav+bATm+HByx8Bhhr1sOQ1ajfs4JTlDIRTcJj2AhNwoMzgYXwcCXaXPp
         Kd0CpkEJj36PrQoD9m9aIIcwmyeDCwbvT8HsOeSRuIF2+7GysXDRfO2PVCYIplWGiPUU
         XeO8IjyflCJ+FctyiOtOaQJM16FMgCp/wzVdZB8f5j2Q7oeaKbMWYiZ/528GC3N4dCd+
         Br7bDKTQSsoQCusxE5NIgznS/5QsGNYrdIUjAZ5rLIMe+puJMHC87pDrtQxFScTUaJM8
         RcdULrEJNRnNXl8KrEGwP0o0QVOtLFc2AQdmLdLQBohFT8p9YAjcAtYkx36476ocBQ/N
         3Zqw==
X-Gm-Message-State: AOJu0YwSLTSusQL9bHx8810icgesUs9j4V4D22KoHjsvGYE+oIRuCJSu
	UeBzSuERTD8BYTX3p0wbxGelVXEP2pN0ODlpk2UMAjqmoOwm9H7cXPkBJN9i2syENcdlRfaMinW
	37Vyj
X-Gm-Gg: AfdE7cnqhziUXpGWVgk5dhQk/A67xizhV9gxYChSZdYhgBZLoRINH4i39ai9gMvuaky
	m5nwaXU/tM8Mp5FXp1e9LJkomkuD5G71d9+h78rNyuFqMML/uF99zNG9c+7xbfupvUJ+KNjH8yd
	vxxoYkxRkTUEvASETLiNuMR3rWSHm2JZJ54sTsSv61Hu4PMbDqv+QGlfIJ/P1yuULZe+nsP1cLS
	YowQtEa9yq4cT3BS/7scE3yaZq1/X3i4DfYtvrVUNSU9PnIHC77bEEOaIphsj8RCUo2wVBRK2Ol
	KS7D0jN82kSzDfhKDfp6qcjDGVa2Vq6eigTrF6SnzJEkdKfjmO56fCyukyyt+sk7hQy1sKqgaf5
	Z/aFFQHjt/bqWxqF+ygSk+3vEH5Cdby7cq3RpjzUryiZ2ls3AbdWkJCrqHsNpN8i3shG53ZP13z
	tEXNWWTYUy7b/e0X8zNJGFG8jlq+1oluZpAWlg20rfHg==
X-Received: by 2002:a05:6000:46c6:b0:461:a15f:6df4 with SMTP id ffacd0b85a97d-477b4fb2b7dmr451014f8f.35.1782911627010;
        Wed, 01 Jul 2026 06:13:47 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:6b3f:20f2:ee05:f032])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47567884770sm17568280f8f.33.2026.07.01.06.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 06:13:44 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net,
	mark.hatle@kernel.crashing.org
Subject: [pseudo] [PATCH 7/7] pseudo_util: Correctly free memory allocated by pseudo_setupenvp
Date: Wed,  1 Jul 2026 14:13:36 +0100
Message-ID: <20260701131336.3578279-7-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260701131336.3578279-1-richard.purdie@linuxfoundation.org>
References: <20260701131336.3578279-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 01 Jul 2026 13:13:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4349

Add a function to properly clean up the environment array memory after use.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 ports/common/guts/execv.c        |  2 +-
 ports/common/guts/execve.c       |  2 +-
 ports/common/guts/execvp.c       |  2 +-
 ports/common/guts/posix_spawn.c  |  2 +-
 ports/common/guts/posix_spawnp.c |  2 +-
 ports/unix/guts/popen.c          |  2 +-
 ports/unix/guts/system.c         |  2 +-
 pseudo.h                         |  1 +
 pseudo_util.c                    | 11 +++++++++++
 9 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/ports/common/guts/execv.c b/ports/common/guts/execv.c
index eb328ed..d4031b3 100644
--- a/ports/common/guts/execv.c
+++ b/ports/common/guts/execv.c
@@ -37,7 +37,7 @@
 	rc = real_execv(file, argv);
 
 	environ = orig_environ;
-	free(new_environ);
+	pseudo_free_envp(new_environ);
 
 /*	return rc;
  * }
diff --git a/ports/common/guts/execve.c b/ports/common/guts/execve.c
index c2be66e..de2f1d4 100644
--- a/ports/common/guts/execve.c
+++ b/ports/common/guts/execve.c
@@ -30,7 +30,7 @@
 	sigprocmask(SIG_SETMASK, &pseudo_saved_sigmask, NULL);
 	rc = real_execve(file, argv, new_environ);
 
-	free(new_environ);
+	pseudo_free_envp(new_environ);
 
 /*	return rc;
  * }
diff --git a/ports/common/guts/execvp.c b/ports/common/guts/execvp.c
index 177e4ee..ffc94be 100644
--- a/ports/common/guts/execvp.c
+++ b/ports/common/guts/execvp.c
@@ -37,7 +37,7 @@
 	rc = real_execvp(file, argv);
 
 	environ = orig_environ;
-	free(new_environ);
+	pseudo_free_envp(new_environ);
 
 /*	return rc;
  * }
diff --git a/ports/common/guts/posix_spawn.c b/ports/common/guts/posix_spawn.c
index 5896893..46ebb0e 100644
--- a/ports/common/guts/posix_spawn.c
+++ b/ports/common/guts/posix_spawn.c
@@ -29,7 +29,7 @@
 	sigprocmask(SIG_SETMASK, &pseudo_saved_sigmask, NULL);
 	rc = real_posix_spawn(pid, path, file_actions, attrp, argv, new_environ);
 
-	free(new_environ);
+	pseudo_free_envp(new_environ);
 
 /*	return rc;
  * }
diff --git a/ports/common/guts/posix_spawnp.c b/ports/common/guts/posix_spawnp.c
index f3dc16b..194bcb3 100644
--- a/ports/common/guts/posix_spawnp.c
+++ b/ports/common/guts/posix_spawnp.c
@@ -29,7 +29,7 @@
 	sigprocmask(SIG_SETMASK, &pseudo_saved_sigmask, NULL);
 	rc = real_posix_spawnp(pid, file, file_actions, attrp, argv, new_environ);
 
-	free(new_environ);
+	pseudo_free_envp(new_environ);
 
 /*	return rc;
  * }
diff --git a/ports/unix/guts/popen.c b/ports/unix/guts/popen.c
index 1d48d04..1ce083d 100644
--- a/ports/unix/guts/popen.c
+++ b/ports/unix/guts/popen.c
@@ -24,7 +24,7 @@
 	rc = real_popen(command, mode);
 
 	environ = orig_environ;
-	free(new_environ);
+	pseudo_free_envp(new_environ);
 
 /*	return rc;
  * }
diff --git a/ports/unix/guts/system.c b/ports/unix/guts/system.c
index 4b374ec..12a3aff 100644
--- a/ports/unix/guts/system.c
+++ b/ports/unix/guts/system.c
@@ -24,7 +24,7 @@
 	rc = real_system(command);
 
 	environ = orig_environ;
-	free(new_environ);
+	pseudo_free_envp(new_environ);
 
 /*	return rc;
  * }
diff --git a/pseudo.h b/pseudo.h
index a2d402c..93a1cea 100644
--- a/pseudo.h
+++ b/pseudo.h
@@ -69,6 +69,7 @@ extern void pseudo_dropenv(void);
 extern char **pseudo_dropenvp(char **);
 extern void pseudo_setupenv(void);
 extern char **pseudo_setupenvp(char * const *);
+extern void pseudo_free_envp(char **envp);
 extern char *pseudo_prefix_path(char *);
 extern char *pseudo_bindir_path(char *);
 extern char *pseudo_libdir_path(char *);
diff --git a/pseudo_util.c b/pseudo_util.c
index 83f92b3..729b65d 100644
--- a/pseudo_util.c
+++ b/pseudo_util.c
@@ -1250,6 +1250,17 @@ pseudo_setupenvp(char * const *envp) {
 	return new_envp;
 }
 
+/* Free data allocated by pseudo_setupenvp() */
+void
+pseudo_free_envp(char **envp) {
+	int i;
+
+	for (i = 0; envp && envp[i]; ++i) {
+		free(envp[i]);
+	}
+	free(envp);
+}
+
 /* Append the file value to the prefix value. */
 char *
 pseudo_append_path(const char * prefix, size_t prefix_len, char *file) {

