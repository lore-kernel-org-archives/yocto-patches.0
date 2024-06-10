Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5EB8C41513
	for <webhook@archiver.kernel.org>; Mon, 10 Jun 2024 14:32:51 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
 by mx.groups.io with SMTP id smtpd.web10.21148.1718029963193889429
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 10 Jun 2024 07:32:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=KJFE+MsX;
 spf=pass (domain: snapchat.com, ip: 209.85.208.42, mailfrom: ecordonnier@snapchat.com)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57c6afa1839so1284085a12.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 10 Jun 2024 07:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1718029961; x=1718634761; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b9EEV1NXUCxl8N8m0MWRNDh2VxngY2Gknbx6qY0KLSo=;
        b=KJFE+MsXIsP39VP/W0bILOGor15FpNgU9k42llZlWrR4U1Rf4EryiVc0Mz2ObHNgVv
         ZQKUXGItwBqJoYI9rrlqR55X2V03I2hoIyInKUDKosp4ESsHK9iI5c3oca83O/sAoihA
         7aAmuL61J3YAsCtC/Vma0haQZeAcjpNHYOwoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718029961; x=1718634761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b9EEV1NXUCxl8N8m0MWRNDh2VxngY2Gknbx6qY0KLSo=;
        b=ICsfBxjPhKAq+zMi3YfcFawAExuEMn+Evz1nwxBWpWGbWekuH6Bp4H1LmljmMcK6Zy
         jvOuBHIkuFOwDaaO9coumBGp+0AJD0ln6xI+Vw5wQpxSlP9JTqLGqb3WauWz0PXRDpst
         /JUIStbzYbxmI9qYISJmiyGK81a/2/TmrLogLIcn1IBh/WfDjhpaI3G4BkkSbBBx2vtz
         fhorolFMZ68teV3xNiq/+9m3QWNcOGJIK5SUrik5sTJa/OLBbL4FoigShBvDlS4jrj3U
         t3ym+0mB8ylqfqvmBY9e6eTQiZO8OJ9b2/7Nx1/m9Qng8FJPT87X9dmP6YbPV7DIXxxx
         TuAw==
X-Gm-Message-State: AOJu0YzUIBp68PKZcY+eM2WxWXkyvtE4yy9upwFbILAAnmZxYL2LyGXQ
	4zjvloFaw4uslKHANtvrvm9m1Y4ExTPUFWiv3/TDSBGlJr57kOSPYRkg1+UMHsuOSBcs0Ow2jMq
	2VGw=
X-Google-Smtp-Source: AGHT+IH8lHl302oWs/adBEYJhUR/o+Tys/hYuiGTN98+YBwS5Pm5wR7DFCY1myU9Cc33nkBQyeP0Kg==
X-Received: by 2002:a50:d7ca:0:b0:578:638e:3683 with SMTP id 4fb4d7f45d1cf-57c50861ae8mr7715078a12.5.1718029961036;
        Mon, 10 Jun 2024 07:32:41 -0700 (PDT)
Received: from lj8k2dq3.sc-core.net ([213.249.125.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae237408sm7504233a12.93.2024.06.10.07.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 07:32:40 -0700 (PDT)
From: ecordonnier@snap.com
To: yocto-patches@lists.yoctoproject.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>
Subject: [meta-darwin][PATCH 03/11] gcc: update to 13.2
Date: Mon, 10 Jun 2024 16:32:06 +0200
Message-Id: <20240610143214.2376414-3-ecordonnier@snap.com>
X-Mailer: git-send-email 2.36.1.vfs.0.0
In-Reply-To: <20240610143214.2376414-1-ecordonnier@snap.com>
References: <20240610143214.2376414-1-ecordonnier@snap.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 10 Jun 2024 14:32:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/285

From: Etienne Cordonnier <ecordonnier@snap.com>

Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 .../clang/0037-Fixes_for_Darwin_SDKs.patch    |   4 +-
 ...e-sysroot-support-for-nativesdk-gcc.patch} | 136 ++++++++++++------
 ...-to-link-commandline-for-musl-targe.patch} |   0
 .../gcc/files/0099-nativesdk-gcc-darwin.patch |   8 +-
 .../gcc/files/0101-optional-libstdc.patch     | 118 ---------------
 recipes-devtools/gcc/gcc-source_%.bbappend    |   1 -
 6 files changed, 102 insertions(+), 165 deletions(-)
 rename recipes-devtools/gcc/files/{0017-handle-sysroot-support-for-nativesdk-gcc.patch => 0016-handle-sysroot-support-for-nativesdk-gcc.patch} (75%)
 rename recipes-devtools/gcc/files/{0020-Add-ssp_nonshared-to-link-commandline-for-musl-targe.patch => 0018-Add-ssp_nonshared-to-link-commandline-for-musl-targe.patch} (100%)
 delete mode 100644 recipes-devtools/gcc/files/0101-optional-libstdc.patch

diff --git a/recipes-devtools/clang/clang/0037-Fixes_for_Darwin_SDKs.patch b/recipes-devtools/clang/clang/0037-Fixes_for_Darwin_SDKs.patch
index c6db8d9..687b5aa 100644
--- a/recipes-devtools/clang/clang/0037-Fixes_for_Darwin_SDKs.patch
+++ b/recipes-devtools/clang/clang/0037-Fixes_for_Darwin_SDKs.patch
@@ -22,13 +22,13 @@ index f7da3f187814..0656f5cbad69 100644
 -                                                "4.2.1",
 -                                                "i686-apple-darwin10",
 -                                                arch == llvm::Triple::x86_64 ? "x86_64" : "");
-+                                                "11.4.0",
++                                                "13.2.0",
 +                                                "x86_64#SDK_VENDOR#-darwin21",
 +                                                "");
        IsBaseFound |= AddGnuCPlusPlusIncludePaths(DriverArgs, CC1Args, UsrIncludeCxx,
 -                                                "4.0.0", "i686-apple-darwin8",
 -                                                 "");
-+                                                "11.4.0", "", "");
++                                                "13.2.0", "", "");
 +      {
 +          const char *S = ::getenv("YOCTO_SDKPATH");
 +          if (S && (S[0] != '\0')) {
diff --git a/recipes-devtools/gcc/files/0017-handle-sysroot-support-for-nativesdk-gcc.patch b/recipes-devtools/gcc/files/0016-handle-sysroot-support-for-nativesdk-gcc.patch
similarity index 75%
rename from recipes-devtools/gcc/files/0017-handle-sysroot-support-for-nativesdk-gcc.patch
rename to recipes-devtools/gcc/files/0016-handle-sysroot-support-for-nativesdk-gcc.patch
index d423e62..79032bd 100644
--- a/recipes-devtools/gcc/files/0017-handle-sysroot-support-for-nativesdk-gcc.patch
+++ b/recipes-devtools/gcc/files/0016-handle-sysroot-support-for-nativesdk-gcc.patch
@@ -1,8 +1,58 @@
-diff --git a/gcc/c-family/c-opts.c b/gcc/c-family/c-opts.c
-index 89e05a4c551..5577383665d 100644
---- a/gcc/c-family/c-opts.c
-+++ b/gcc/c-family/c-opts.c
-@@ -1436,8 +1436,8 @@ add_prefixed_path (const char *suffix, incpath_kind chain)
+From 79f4e2447d4eedca05310f7cede73d17714b7f3a Mon Sep 17 00:00:00 2001
+From: Etienne Cordonnier <ecordonnier@snap.com>
+Date: Sun, 9 Jun 2024 20:56:32 +0200
+Subject: [PATCH] handle sysroot support for nativesdk-gcc
+
+Being able to build a nativesdk gcc is useful, particularly in cases
+where the host compiler may be of an incompatible version (or a 32
+bit compiler is needed).
+
+Sadly, building nativesdk-gcc is not straight forward. We install
+nativesdk-gcc into a relocatable location and this means that its
+library locations can change. "Normal" sysroot support doesn't help
+in this case since the values of paths like "libdir" change, not just
+base root directory of the system.
+
+In order to handle this we do two things:
+
+a) Add %r into spec file markup which can be used for injected paths
+   such as SYSTEMLIBS_DIR (see gcc_multilib_setup()).
+b) Add other paths which need relocation into a .gccrelocprefix section
+   which the relocation code will notice and adjust automatically.
+
+Upstream-Status: Inappropriate
+RP 2015/7/28
+
+Extend the gccrelocprefix support to musl config too, this ensures
+that gcc will get right bits in SDK installations
+
+Signed-off-by: Khem Raj <raj.khem@gmail.com>
+
+Added PREFIXVAR and EXEC_PREFIXVAR to support runtime relocation.  Without
+these as part of the gccrelocprefix the system can't do runtime relocation
+if the executable is moved.  (These paths were missed in the original
+implementation.)
+
+Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>
+
+gcc: properly handle yocto sysroot paches on darwin
+
+Signed-off-by: Dominik Schnitzer <dominik@snap.com>
+
+---
+ gcc/c-family/c-opts.cc |  4 +--
+ gcc/cppdefault.cc      | 73 +++++++++++++++++++++++++++---------------
+ gcc/cppdefault.h       | 17 +++++-----
+ gcc/gcc.cc             | 25 +++++++++++----
+ gcc/incpath.cc         | 12 +++----
+ gcc/prefix.cc          | 11 +++++--
+ 6 files changed, 93 insertions(+), 49 deletions(-)
+
+diff --git a/gcc/c-family/c-opts.cc b/gcc/c-family/c-opts.cc
+index c68a2a27469..77e9b5eceaa 100644
+--- a/gcc/c-family/c-opts.cc
++++ b/gcc/c-family/c-opts.cc
+@@ -1458,8 +1458,8 @@ add_prefixed_path (const char *suffix, incpath_kind chain)
    size_t prefix_len, suffix_len;
  
    suffix_len = strlen (suffix);
@@ -13,10 +63,10 @@ index 89e05a4c551..5577383665d 100644
  
    path = (char *) xmalloc (prefix_len + suffix_len + 1);
    memcpy (path, prefix, prefix_len);
-diff --git a/gcc/cppdefault.c b/gcc/cppdefault.c
-index d54d6ce0076..7e8e8141ad8 100644
---- a/gcc/cppdefault.c
-+++ b/gcc/cppdefault.c
+diff --git a/gcc/cppdefault.cc b/gcc/cppdefault.cc
+index 734590a7059..90348a2e2e2 100644
+--- a/gcc/cppdefault.cc
++++ b/gcc/cppdefault.cc
 @@ -35,6 +35,38 @@
  # undef CROSS_INCLUDE_DIR
  #endif
@@ -89,7 +139,7 @@ index d54d6ce0076..7e8e8141ad8 100644
  #endif
  #ifdef GCC_INCLUDE_SUBDIR_TARGET
      /* This is the dir for gcc's private headers under the specified sysroot.  */
-@@ -70,15 +102,15 @@ const struct default_include cpp_include_defaults[]
+@@ -70,18 +102,18 @@ const struct default_include cpp_include_defaults[]
  #endif
  #ifdef LOCAL_INCLUDE_DIR
      /* /usr/local/include comes before the fixincluded header files.  */
@@ -104,12 +154,16 @@ index d54d6ce0076..7e8e8141ad8 100644
  #endif
  #ifdef FIXED_INCLUDE_DIR
      /* This is the dir for fixincludes.  */
+ #ifndef SYSROOT_HEADERS_SUFFIX_SPEC
+-    { FIXED_INCLUDE_DIR, "GCC", 0, 0, 0, 2 },
++    { FIXED_INCLUDE_DIRVAR, "GCC", 0, 0, 0, 2 },
+ #endif
 -    { FIXED_INCLUDE_DIR, "GCC", 0, 0, 0,
 +    { FIXED_INCLUDE_DIRVAR, "GCC", 0, 0, 0,
        /* A multilib suffix needs adding if different multilibs use
  	 different headers.  */
  #ifdef SYSROOT_HEADERS_SUFFIX_SPEC
-@@ -90,33 +122,24 @@ const struct default_include cpp_include_defaults[]
+@@ -93,33 +125,24 @@ const struct default_include cpp_include_defaults[]
  #endif
  #ifdef CROSS_INCLUDE_DIR
      /* One place the target system's headers might be.  */
@@ -150,20 +204,19 @@ index d54d6ce0076..7e8e8141ad8 100644
  /* This value is set by cpp_relocated at runtime */
  const char *gcc_exec_prefix;
 diff --git a/gcc/cppdefault.h b/gcc/cppdefault.h
-index fd3c655db1c..fd730aaf9cf 100644
+index e26b424e99c..53c2c4be41d 100644
 --- a/gcc/cppdefault.h
 +++ b/gcc/cppdefault.h
-@@ -33,7 +33,8 @@
+@@ -33,7 +33,7 @@
  
  struct default_include
  {
 -  const char *const fname;	/* The name of the directory.  */
-+  const char *fname;     /* The name of the directory.  */
-+
++  const char *fname;	/* The name of the directory.  */
    const char *const component;	/* The component containing the directory
- 				   (see update_path in prefix.c) */
+ 				   (see update_path in prefix.cc) */
    const char cplusplus;		/* When this is non-zero, we should only
-@@ -55,17 +56,18 @@ struct default_include
+@@ -55,17 +55,18 @@ struct default_include
  };
  
  extern const struct default_include cpp_include_defaults[];
@@ -189,11 +242,11 @@ index fd3c655db1c..fd730aaf9cf 100644
  /* The run-time execution prefix.  This is typically the lib/gcc
     subdirectory of the actual installation.  */
  extern const char *gcc_exec_prefix;
-diff --git a/gcc/gcc.c b/gcc/gcc.c
-index 584122486cb..c9800046566 100644
---- a/gcc/gcc.c
-+++ b/gcc/gcc.c
-@@ -252,6 +252,13 @@ FILE *report_times_to_file = NULL;
+diff --git a/gcc/gcc.cc b/gcc/gcc.cc
+index 16bb07f2cdc..70afa2704bd 100644
+--- a/gcc/gcc.cc
++++ b/gcc/gcc.cc
+@@ -255,6 +255,13 @@ FILE *report_times_to_file = NULL;
  #endif
  static const char *target_system_root = DEFAULT_TARGET_SYSTEM_ROOT;
  
@@ -207,7 +260,7 @@ index 584122486cb..c9800046566 100644
  /* Nonzero means pass the updated target_system_root to the compiler.  */
  
  static int target_system_root_changed;
-@@ -568,6 +575,7 @@ or with constant text in a single argument.
+@@ -578,6 +585,7 @@ or with constant text in a single argument.
   %G     process LIBGCC_SPEC as a spec.
   %R     Output the concatenation of target_system_root and
          target_sysroot_suffix.
@@ -215,7 +268,7 @@ index 584122486cb..c9800046566 100644
   %S     process STARTFILE_SPEC as a spec.  A capital S is actually used here.
   %E     process ENDFILE_SPEC as a spec.  A capital E is actually used here.
   %C     process CPP_SPEC as a spec.
-@@ -1620,10 +1628,10 @@ static const char *gcc_libexec_prefix;
+@@ -1614,10 +1622,10 @@ static const char *gcc_libexec_prefix;
     gcc_exec_prefix is set because, in that case, we know where the
     compiler has been installed, and use paths relative to that
     location instead.  */
@@ -230,7 +283,7 @@ index 584122486cb..c9800046566 100644
  
  /* For native compilers, these are well-known paths containing
     components that may be provided by the system.  For cross
-@@ -1631,9 +1639,9 @@ static const char *const standard_startfile_prefix = STANDARD_STARTFILE_PREFIX;
+@@ -1625,9 +1633,9 @@ static const char *const standard_startfile_prefix = STANDARD_STARTFILE_PREFIX;
  static const char *md_exec_prefix = MD_EXEC_PREFIX;
  static const char *md_startfile_prefix = MD_STARTFILE_PREFIX;
  static const char *md_startfile_prefix_1 = MD_STARTFILE_PREFIX_1;
@@ -242,7 +295,7 @@ index 584122486cb..c9800046566 100644
    = STANDARD_STARTFILE_PREFIX_2;
  
  /* A relative path to be used in finding the location of tools
-@@ -6564,6 +6572,11 @@ do_spec_1 (const char *spec, int inswitch, const char *soft_matched_part)
+@@ -6647,6 +6655,11 @@ do_spec_1 (const char *spec, int inswitch, const char *soft_matched_part)
  	      }
  	    break;
  
@@ -254,11 +307,11 @@ index 584122486cb..c9800046566 100644
  	  case 'S':
  	    value = do_spec_1 (startfile_spec, 0, NULL);
  	    if (value != 0)
-diff --git a/gcc/incpath.c b/gcc/incpath.c
-index fbfc0ce03b8..a82e543428b 100644
---- a/gcc/incpath.c
-+++ b/gcc/incpath.c
-@@ -131,7 +131,7 @@ add_standard_paths (const char *sysroot, const char *iprefix,
+diff --git a/gcc/incpath.cc b/gcc/incpath.cc
+index 4d44321183f..19a5f880fd3 100644
+--- a/gcc/incpath.cc
++++ b/gcc/incpath.cc
+@@ -134,7 +134,7 @@ add_standard_paths (const char *sysroot, const char *iprefix,
    int relocated = cpp_relocated ();
    size_t len;
  
@@ -267,7 +320,7 @@ index fbfc0ce03b8..a82e543428b 100644
      {
        /* Look for directories that start with the standard prefix.
  	 "Translate" them, i.e. replace /usr/local/lib/gcc... with
-@@ -146,7 +146,7 @@ add_standard_paths (const char *sysroot, const char *iprefix,
+@@ -149,7 +149,7 @@ add_standard_paths (const char *sysroot, const char *iprefix,
  		 now.  */
  	      if (sysroot && p->add_sysroot)
  		continue;
@@ -276,7 +329,7 @@ index fbfc0ce03b8..a82e543428b 100644
  		{
  		  char *str = concat (iprefix, p->fname + len, NULL);
  		  if (p->multilib == 1 && imultilib)
-@@ -187,7 +187,7 @@ add_standard_paths (const char *sysroot, const char *iprefix,
+@@ -190,7 +190,7 @@ add_standard_paths (const char *sysroot, const char *iprefix,
  	      free (sysroot_no_trailing_dir_separator);
  	    }
  	  else if (!p->add_sysroot && relocated
@@ -285,7 +338,7 @@ index fbfc0ce03b8..a82e543428b 100644
  	    {
   	      static const char *relocated_prefix;
  	      char *ostr;
-@@ -204,12 +204,12 @@ add_standard_paths (const char *sysroot, const char *iprefix,
+@@ -207,12 +207,12 @@ add_standard_paths (const char *sysroot, const char *iprefix,
  		  dummy = concat (gcc_exec_prefix, "dummy", NULL);
  		  relocated_prefix
  		    = make_relative_prefix (dummy,
@@ -301,11 +354,11 @@ index fbfc0ce03b8..a82e543428b 100644
  			     NULL);
  	      str = update_path (ostr, p->component);
  	      free (ostr);
-diff --git a/gcc/prefix.c b/gcc/prefix.c
-index 747c09de638..da598c43a52 100644
---- a/gcc/prefix.c
-+++ b/gcc/prefix.c
-@@ -72,7 +72,14 @@ License along with GCC; see the file COPYING3.  If not see
+diff --git a/gcc/prefix.cc b/gcc/prefix.cc
+index c2a37bde5ea..b5d0eb75c7c 100644
+--- a/gcc/prefix.cc
++++ b/gcc/prefix.cc
+@@ -73,7 +73,14 @@ License along with GCC; see the file COPYING3.  If not see
  #include "prefix.h"
  #include "common/common-target.h"
  
@@ -321,7 +374,7 @@ index 747c09de638..da598c43a52 100644
  
  static const char *get_key_value (char *);
  static char *translate_name (char *);
-@@ -212,7 +219,7 @@ translate_name (char *name)
+@@ -213,7 +220,7 @@ translate_name (char *name)
  	prefix = getenv (key);
  
        if (prefix == 0)
@@ -330,3 +383,6 @@ index 747c09de638..da598c43a52 100644
  
        /* We used to strip trailing DIR_SEPARATORs here, but that can
  	 sometimes yield a result with no separator when one was coded
+-- 
+2.34.1
+
diff --git a/recipes-devtools/gcc/files/0020-Add-ssp_nonshared-to-link-commandline-for-musl-targe.patch b/recipes-devtools/gcc/files/0018-Add-ssp_nonshared-to-link-commandline-for-musl-targe.patch
similarity index 100%
rename from recipes-devtools/gcc/files/0020-Add-ssp_nonshared-to-link-commandline-for-musl-targe.patch
rename to recipes-devtools/gcc/files/0018-Add-ssp_nonshared-to-link-commandline-for-musl-targe.patch
diff --git a/recipes-devtools/gcc/files/0099-nativesdk-gcc-darwin.patch b/recipes-devtools/gcc/files/0099-nativesdk-gcc-darwin.patch
index 77419c0..a0a24cc 100644
--- a/recipes-devtools/gcc/files/0099-nativesdk-gcc-darwin.patch
+++ b/recipes-devtools/gcc/files/0099-nativesdk-gcc-darwin.patch
@@ -7,14 +7,14 @@ Subject: [PATCH] rebase patch "0099-nativesdk-gcc-darwin.patch" from
 Upstream-Status: Inappropriate [OE specific]
 Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
 ---
- gcc/config/darwin-c.c | 4 ++--
+ gcc/config/darwin-c.cc | 4 ++--
  gcc/config/darwin.h   | 5 +----
  2 files changed, 3 insertions(+), 6 deletions(-)
 
-diff --git a/gcc/config/darwin-c.c b/gcc/config/darwin-c.c
+diff --git a/gcc/config/darwin-c.cc b/gcc/config/darwin-c.cc
 index 8b3dec25476..a3c71f109a8 100644
---- a/gcc/config/darwin-c.c
-+++ b/gcc/config/darwin-c.c
+--- a/gcc/config/darwin-c.cc
++++ b/gcc/config/darwin-c.cc
 @@ -479,8 +479,8 @@ darwin_register_objc_includes (const char *sysroot ATTRIBUTE_UNUSED,
       /* See if our directory starts with the standard prefix.
  	 "Translate" them, i.e. replace /usr/local/lib/gcc... with
diff --git a/recipes-devtools/gcc/files/0101-optional-libstdc.patch b/recipes-devtools/gcc/files/0101-optional-libstdc.patch
deleted file mode 100644
index 1c62c96..0000000
--- a/recipes-devtools/gcc/files/0101-optional-libstdc.patch
+++ /dev/null
@@ -1,118 +0,0 @@
-From: Richard Purdie <richard.purdie@linuxfoundation.org>
-Subject: [PATCH 3/5] gcc: Add --nostdlib++ option
-
-[gcc-runtime builds libstdc++ separately from gcc-cross-*. Its configure tests using g++
-will not run correctly since by default the linker will try to link against libstdc++
-which shouldn't exist yet. We need an option to disable -lstdc++
-option whilst leaving -lc, -lgcc and other automatic library dependencies added by gcc
-driver. This patch adds such an option which only disables the -lstdc++.]
-
-[A "standard" gcc build uses xgcc and hence avoids this. We should ask upstream how to
-do this officially, the likely answer is don't build libstdc++ separately.]
-
-OpenEmbedded/Yocto Project builds libgcc and the other gcc runtime libraries
-separately from the compiler and slightly differently to the standard gcc build.
-
-In general this works well but in trying to build them separately we run into
-an issue since we're using our gcc, not xgcc and there is no way to tell configure
-to use libgcc but not look for libstdc++.
-
-This adds such an option allowing such configurations to work.
-
-2021-10-26 Richard Purdie <richard.purdie@linuxfoundation.org>
-
-gcc/c-family/ChangeLog:
-
-    * c.opt: Add --nostdlib++ option
-
-gcc/cp/ChangeLog:
-
-    * g++spec.c (lang_specific_driver): Add --nostdlib++ option
-
-gcc/ChangeLog:
-
-    * doc/invoke.texi: Document --nostdlib++ option
-    * gcc.c: Add --nostdlib++ option
-
-Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
-
-Upstream-Status: Submitted [https://gcc.gnu.org/pipermail/gcc-patches/2021-October/582724.html]
----
- gcc/c-family/c.opt  | 4 ++++
- gcc/cp/g++spec.c    | 1 +
- gcc/doc/invoke.texi | 8 +++++++-
- gcc/gcc.c           | 1 +
- 4 files changed, 13 insertions(+), 1 deletion(-)
-
-Index: gcc-11.3.0/gcc/c-family/c.opt
-===================================================================
---- gcc-11.3.0.orig/gcc/c-family/c.opt
-+++ gcc-11.3.0/gcc/c-family/c.opt
-@@ -2153,6 +2153,10 @@ nostdinc++
- C++ ObjC++
- Do not search standard system include directories for C++.
- 
-+nostdlib++
-+Driver
-+Do not link standard C++ runtime library
-+
- o
- C ObjC C++ ObjC++ Joined Separate
- ; Documented in common.opt
-Index: gcc-11.3.0/gcc/cp/g++spec.c
-===================================================================
---- gcc-11.3.0.orig/gcc/cp/g++spec.c
-+++ gcc-11.3.0/gcc/cp/g++spec.c
-@@ -159,6 +159,7 @@ lang_specific_driver (struct cl_decoded_
-       switch (decoded_options[i].opt_index)
- 	{
- 	case OPT_nostdlib:
-+	case OPT_nostdlib__:
- 	case OPT_nodefaultlibs:
- 	  library = -1;
- 	  break;
-Index: gcc-11.3.0/gcc/doc/invoke.texi
-===================================================================
---- gcc-11.3.0.orig/gcc/doc/invoke.texi
-+++ gcc-11.3.0/gcc/doc/invoke.texi
-@@ -239,6 +239,7 @@ in the following sections.
- -fno-weak  -nostdinc++ @gol
- -fvisibility-inlines-hidden @gol
- -fvisibility-ms-compat @gol
-+-nostdlib++ @gol
- -fext-numeric-literals @gol
- -flang-info-include-translate@r{[}=@var{header}@r{]} @gol
- -flang-info-include-translate-not @gol
-@@ -632,7 +633,7 @@ Objective-C and Objective-C++ Dialects}.
- -pie  -pthread  -r  -rdynamic @gol
- -s  -static  -static-pie  -static-libgcc  -static-libstdc++ @gol
- -static-libasan  -static-libtsan  -static-liblsan  -static-libubsan @gol
---shared  -shared-libgcc  -symbolic @gol
-+-shared  -shared-libgcc  -symbolic -nostdlib++ @gol
- -T @var{script}  -Wl,@var{option}  -Xlinker @var{option} @gol
- -u @var{symbol}  -z @var{keyword}}
- 
-@@ -15721,6 +15722,11 @@ Specify that the program entry point is
- interpreted by the linker; the GNU linker accepts either a symbol name
- or an address.
- 
-+@item -nostdlib++
-+@opindex nostdlib++
-+Do not use the standard system C++ runtime libraries when linking.
-+Only the libraries you specify will be passed to the linker.
-+
- @item -pie
- @opindex pie
- Produce a dynamically linked position independent executable on targets
-Index: gcc-11.3.0/gcc/gcc.c
-===================================================================
---- gcc-11.3.0.orig/gcc/gcc.c
-+++ gcc-11.3.0/gcc/gcc.c
-@@ -1162,6 +1162,7 @@ proper position among the other output f
-     %(mflib) " STACK_SPLIT_SPEC "\
-     %{fprofile-arcs|fprofile-generate*|coverage:-lgcov} " SANITIZER_SPEC " \
-     %{!nostdlib:%{!r:%{!nodefaultlibs:%(link_ssp) %(link_gcc_c_sequence)}}}\
-+    %{!nostdlib++:}\
-     %{!nostdlib:%{!r:%{!nostartfiles:%E}}} %{T*}  \n%(post_link) }}}}}}"
- #endif
- 
diff --git a/recipes-devtools/gcc/gcc-source_%.bbappend b/recipes-devtools/gcc/gcc-source_%.bbappend
index 110462d..296a688 100644
--- a/recipes-devtools/gcc/gcc-source_%.bbappend
+++ b/recipes-devtools/gcc/gcc-source_%.bbappend
@@ -3,5 +3,4 @@ FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
 SRC_URI:append = "\
     file://0099-nativesdk-gcc-darwin.patch \
     file://0100-change-macosx-version-min-to-12.3.patch \
-    file://0101-optional-libstdc.patch \
 "
-- 
2.36.1.vfs.0.0


