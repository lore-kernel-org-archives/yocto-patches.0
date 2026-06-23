Return-Path: <jackson.james9803@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0D4CD4F26
	for <webhook@archiver.kernel.org>; Tue, 23 Jun 2026 09:56:12 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17305.1782208567720961283
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 23 Jun 2026 02:56:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=g4sKEwLP;
 spf=pass (domain: gmail.com, ip: 209.85.214.170, mailfrom: jackson.james9803@gmail.com)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c7cfa17fedso2107105ad.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 23 Jun 2026 02:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782208567; x=1782813367; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j2ta1N81oVOIbf8wpDuHsgXKtRxxR49MLcd55Vnv0mQ=;
        b=g4sKEwLPZpdC7h8HdLLHGOTLuphStG5CyDMCDeimtW32/Px0iXTKv5XhjqUxMtKKCu
         JF6l14S/VCV2R3C7dm5BCTQYYW+UU0gVt5DQc5MfBiegARcKeFnrR9zflIpczOTefv+0
         sWjR8D0nG1IDVMQSCT01ByhgHcnJPQpF6ZPQIXGs5BJkhCuMFI13qmH5hjCFksiFel3K
         En8napzWPVRCSr4PAJ+DPObUN1VLNeeAoMtVm1wcMCGl24tSi+FLOpnvuNLBTAXjTVVu
         1IT1v6Jz2sWBMX3SplYSt/QP0/wJok+ISNxptuMgAYAzjsqVPZ1SHKXQwi0M5aLRKXPR
         7E7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782208567; x=1782813367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j2ta1N81oVOIbf8wpDuHsgXKtRxxR49MLcd55Vnv0mQ=;
        b=I3Sd/5LK43gSKdDfuZpqtgfMuTvBTH+Jn9uB011ETh5LlzHDqhL5DMHBIsaZTBACvx
         61e6qrItUxHwTfxuSZxIUwQ2ouB59zfwVHv0hWOstEMuos9SeejUV+oDZ/3TBehCxE3+
         g9J4e6v0Rf8ZaNJroMfF6aw2+jm/PCARemxJ5pQDir4fbt0v4CRD0AEMD24etBXdWxds
         Q4iAm69uOSZHz+ta1JQkD20I6507snVlmgbV6h8bvJc+9DKFgXVKffA+5ATQ9f+Y37zY
         nuvl5QxHj41UqVzEaBlx3YTov1nyoHntKLAWmHMXXS8rXJc8fd1LSwDm/soOBINRtLBZ
         1rRQ==
X-Gm-Message-State: AOJu0YyChFhPY38cXHSUSWEevywS3eXwudrB5hMGqgPWNeJcezHRyjRK
	FCwt9PtpQRN+lWgFAZgP7WSwnBmI8PkjX6g3g29KmCsOzl5ZI6esn/mklWO0UjLb
X-Gm-Gg: AfdE7cmRAHhLUkn3CKdAE2AggyaPK/66vceCJvHHQwXY7NXjCnZdqyhbtvEAD4sx35I
	Hzijfvy6TsvXDko624IOQceKi4O3Y9aZS1OUdt9X5WPQb3hhfhe8ILLQAGDpPfrafe8s5QEsmPy
	rsROR6JMe3A2EH22zevpgmplywxWDiILNugsqxJ6BhPKsxFqt/3LFJJnWES9aclMvoyTWqB8Hzv
	PMNjyJ/DM8+f5YRuCebE8sjDCZT+qN+pAR16jZ5OU4WziymDyYtzoySGzv7o23TSF5h5Akn0NeN
	I2Wynee/DR/KOKPShK3qC6/+JuiBoaoZMR+aV7JqhEukc9tfRQKjdm/UcQVbIHGXQc8uTxASdp1
	EcYL3frXRoFF2FmWdynhbOeEy29AcFvmEtvHwn3PeKEmDGs36Xm104FpqkPlZYNsAw67e18ce7v
	mP8tN9bgCj+hjCsM8h
X-Received: by 2002:a17:903:19cb:b0:2c6:b40a:d0c7 with SMTP id d9443c01a7336-2c7c99435b2mr17071125ad.7.1782208566874;
        Tue, 23 Jun 2026 02:56:06 -0700 (PDT)
Received: from LL-868L.kpit.com ([157.45.208.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7439f8e42sm100432365ad.48.2026.06.23.02.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 02:56:06 -0700 (PDT)
From: Jackson James <jackson.james9803@gmail.com>
X-Google-Original-From: Jackson James <jacksonj2@kpit.com>
To: yocto-patches@lists.yoctoproject.org
Cc: careers.myinfo@gmail.com
Subject: [meta-lts-collab][kirkstone][PATCH] spirv: Use STACK_ARRAY instead of NIR_VLA
Date: Tue, 23 Jun 2026 15:25:32 +0530
Message-Id: <20260623095532.159994-1-jacksonj2@kpit.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 23 Jun 2026 09:56:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4277

From: Shaik Moin <careers.myinfo@gmail.com>

The number of fields comes from the shader, so it could be a value large
enough that using alloca would be problematic.

Signed-off-by: Shaik Moin <careers.myinfo@gmail.com>
---
 ...0001-util-Move-STACK_ARRAY-into-util.patch |  83 ++++++++++++++
 .../mesa/files/CVE-2026-40393.patch           | 103 ++++++++++++++++++
 meta-oe/recipes-graphics/mesa/mesa_%.bbappend |   5 +
 3 files changed, 191 insertions(+)
 create mode 100644 meta-oe/recipes-graphics/mesa/files/0001-util-Move-STACK_ARRAY-into-util.patch
 create mode 100644 meta-oe/recipes-graphics/mesa/files/CVE-2026-40393.patch
 create mode 100644 meta-oe/recipes-graphics/mesa/mesa_%.bbappend

diff --git a/meta-oe/recipes-graphics/mesa/files/0001-util-Move-STACK_ARRAY-into-util.patch b/meta-oe/recipes-graphics/mesa/files/0001-util-Move-STACK_ARRAY-into-util.patch
new file mode 100644
index 0000000..49aa1b0
--- /dev/null
+++ b/meta-oe/recipes-graphics/mesa/files/0001-util-Move-STACK_ARRAY-into-util.patch
@@ -0,0 +1,83 @@
+From 8dfa16221058327dbfed11aafff963ac73334756 Mon Sep 17 00:00:00 2001
+From: Shaik Moin <careers.myinfo@gmail.com>
+Date: Fri, 19 Jun 2026 16:40:02 +0530
+Subject: [PATCH] util: Move STACK_ARRAY into util
+
+It's useful for more than just Vulkan.
+
+Reference:
+https://gitlab.freedesktop.org/mesa/mesa/-/commit/f43cff3728e58c377d1e03b13db62514217abfe1.patch
+
+Signed-off-by: Shaik Moin <careers.myinfo@gmail.com>
+---
+ src/util/meson.build   |  1 +
+ src/util/stack_array.h | 45 ++++++++++++++++++++++++++++++++++++++++++
+ 2 files changed, 46 insertions(+)
+ create mode 100644 src/util/stack_array.h
+
+diff --git a/src/util/meson.build b/src/util/meson.build
+index 6e77a2f..9c37972 100644
+--- a/src/util/meson.build
++++ b/src/util/meson.build
+@@ -110,6 +110,7 @@ files_mesa_util = files(
+   'softfloat.h',
+   'sparse_array.c',
+   'sparse_array.h',
++  'stack_array.h',
+   'string_buffer.c',
+   'string_buffer.h',
+   'strndup.h',
+diff --git a/src/util/stack_array.h b/src/util/stack_array.h
+new file mode 100644
+index 0000000..e2133bd
+--- /dev/null
++++ b/src/util/stack_array.h
+@@ -0,0 +1,45 @@
++/*
++ * Copyright © 2025 Collabora, Ltd.
++ *
++ * Permission is hereby granted, free of charge, to any person obtaining a
++ * copy of this software and associated documentation files (the "Software"),
++ * to deal in the Software without restriction, including without limitation
++ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
++ * and/or sell copies of the Software, and to permit persons to whom the
++ * Software is furnished to do so, subject to the following conditions:
++ *
++ * The above copyright notice and this permission notice (including the next
++ * paragraph) shall be included in all copies or substantial portions of the
++ * Software.
++ *
++ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
++ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
++ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
++ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
++ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
++ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
++ * IN THE SOFTWARE.
++ */
++
++#include <stdlib.h>
++
++#ifndef UTIL_STACK_ARRAY_H
++#define UTIL_STACK_ARRAY_H
++
++#define STACK_ARRAY_SIZE 8
++
++/* Sometimes gcc may claim -Wmaybe-uninitialized for the stack array in some
++ * places it can't verify that when size is 0 nobody down the call chain reads
++ * the array. Please don't try to fix it by zero-initializing the array here
++ * since it's used in a lot of different places. An "if (size == 0) return;"
++ * may work for you.
++ */
++#define STACK_ARRAY(type, name, size) \
++   type _stack_##name[STACK_ARRAY_SIZE]; \
++   type *const name = \
++     ((size) <= STACK_ARRAY_SIZE ? _stack_##name : (type *)malloc((size) * sizeof(type)))
++
++#define STACK_ARRAY_FINISH(name) \
++   if (name != _stack_##name) free(name)
++
++#endif /* UTIL_STACK_ARRAY_H */
+-- 
+2.34.1
+
diff --git a/meta-oe/recipes-graphics/mesa/files/CVE-2026-40393.patch b/meta-oe/recipes-graphics/mesa/files/CVE-2026-40393.patch
new file mode 100644
index 0000000..e35e5a4
--- /dev/null
+++ b/meta-oe/recipes-graphics/mesa/files/CVE-2026-40393.patch
@@ -0,0 +1,103 @@
+From e240e44e1967b9f605225ecddbf07f307952c814 Mon Sep 17 00:00:00 2001
+From: Shaik Moin <careers.myinfo@gmail.com>
+Date: Mon, 8 Jun 2026 12:21:41 +0530
+Subject: [PATCH] spirv: Use STACK_ARRAY instead of NIR_VLA
+
+The number of fields comes from the shader, so it could be a value large
+enough that using alloca would be problematic.
+
+Backport the fix for CVE-2026-40393
+
+CVE: CVE-2026-40393
+
+Upstream-Status: Backport [https://gitlab.freedesktop.org/mesa/mesa/-/commit/978fd42b4b7d1e9c0435ffa7e1a4d339cba9b76e]
+
+Patch is refreshed based on code base.
+
+Fixes: 2a023f30a64 ("nir/spirv: Add basic support for types")
+Reviewed-by: Caio Oliveira <caio.oliveira@intel.com>
+Reviewed-by: Ryan Neph <ryanneph@google.com>
+Reviewed-by: Lionel Landwerlin <lionel.g.landwerlin@intel.com>
+Signed-off-by: Shaik Moin <moin.shaik@partner.bmwgroup.com>
+---
+ src/compiler/spirv/spirv_to_nir.c | 18 ++++++++++++------
+ 1 file changed, 12 insertions(+), 6 deletions(-)
+
+diff --git a/src/compiler/spirv/spirv_to_nir.c b/src/compiler/spirv/spirv_to_nir.c
+index 79e176a..68da937 100644
+--- a/src/compiler/spirv/spirv_to_nir.c
++++ b/src/compiler/spirv/spirv_to_nir.c
+@@ -26,7 +26,6 @@
+  */
+ 
+ #include "vtn_private.h"
+-#include "nir/nir_vla.h"
+ #include "nir/nir_control_flow.h"
+ #include "nir/nir_constant_expressions.h"
+ #include "nir/nir_deref.h"
+@@ -35,6 +34,7 @@
+ #include "util/format/u_format.h"
+ #include "util/u_math.h"
+ #include "util/u_string.h"
++#include "util/stack_array.h"
+ 
+ #include <stdio.h>
+ 
+@@ -926,7 +926,7 @@ vtn_type_get_nir_type(struct vtn_builder *b, struct vtn_type *type,
+       case vtn_base_type_struct: {
+          bool need_new_struct = false;
+          const uint32_t num_fields = type->length;
+-         NIR_VLA(struct glsl_struct_field, fields, num_fields);
++         STACK_ARRAY(struct glsl_struct_field, fields, num_fields);
+          for (unsigned i = 0; i < num_fields; i++) {
+             fields[i] = *glsl_get_struct_field_data(type->type, i);
+             const struct glsl_type *field_nir_type =
+@@ -936,20 +936,25 @@ vtn_type_get_nir_type(struct vtn_builder *b, struct vtn_type *type,
+                need_new_struct = true;
+             }
+          }
++
++	 const struct glsl_type *result;
+          if (need_new_struct) {
+             if (glsl_type_is_interface(type->type)) {
+-               return glsl_interface_type(fields, num_fields,
++               result = glsl_interface_type(fields, num_fields,
+                                           /* packing */ 0, false,
+                                           glsl_get_type_name(type->type));
+             } else {
+-               return glsl_struct_type(fields, num_fields,
++               result = glsl_struct_type(fields, num_fields,
+                                        glsl_get_type_name(type->type),
+                                        glsl_struct_type_is_packed(type->type));
+             }
+          } else {
+             /* No changes, just pass it on */
+-            return type->type;
++            result = type->type;
+          }
++
++	 STACK_ARRAY_FINISH(fields);
++	 return result;
+       }
+ 
+       case vtn_base_type_image:
+@@ -1519,7 +1524,7 @@ vtn_handle_type(struct vtn_builder *b, SpvOp opcode,
+       val->type->offsets = ralloc_array(b, unsigned, num_fields);
+       val->type->packed = false;
+ 
+-      NIR_VLA(struct glsl_struct_field, fields, count);
++      STACK_ARRAY(struct glsl_struct_field, fields, count);
+       for (unsigned i = 0; i < num_fields; i++) {
+          val->type->members[i] = vtn_get_type(b, w[i + 2]);
+          const char *name = NULL;
+@@ -1575,6 +1580,7 @@ vtn_handle_type(struct vtn_builder *b, SpvOp opcode,
+                                             name ? name : "struct",
+                                             val->type->packed);
+       }
++      STACK_ARRAY_FINISH(fields);
+       break;
+    }
+ 
+-- 
+2.34.1
+
diff --git a/meta-oe/recipes-graphics/mesa/mesa_%.bbappend b/meta-oe/recipes-graphics/mesa/mesa_%.bbappend
new file mode 100644
index 0000000..553264a
--- /dev/null
+++ b/meta-oe/recipes-graphics/mesa/mesa_%.bbappend
@@ -0,0 +1,5 @@
+FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
+
+SRC_URI += "file://CVE-2026-40393.patch \
+            file://0001-util-Move-STACK_ARRAY-into-util.patch \
+"
-- 
2.34.1


