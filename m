Return-Path: <jackson.james9803@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55081CDB47F
	for <webhook@archiver.kernel.org>; Wed, 24 Jun 2026 08:59:23 +0000 (UTC)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2681.1782291554483887762
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 24 Jun 2026 01:59:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=sXAIYvXI;
 spf=pass (domain: gmail.com, ip: 209.85.208.46, mailfrom: jackson.james9803@gmail.com)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-697ce8cfe65so1210407a12.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 24 Jun 2026 01:59:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782291553; cv=none;
        d=google.com; s=arc-20240605;
        b=NBDOdaPzsG0E9aoBfDO62R55IGHRUCyfwClkrMadimmzPB6Tzt0pljh1yLZ3bQ8ODK
         eXec19v+yQCOQcKtW36DdhW6dmHaiGasCoe0iUPI85MxgmT87i7fRL6c5Cw2z2SRnoZr
         s6cHjyJK3LldENY4Rd9c9wxy67Qx2mDHhfRTiAQ9FAM/i1HpfiWqRjAZ6vBUJyi4ZJwl
         KJj6ala1Cuzcrf31kLdst9My5z4rffj6cecdxzsW+G/AYcw0x1LT2LRR7xS1dqg014Ui
         88yY4zVFC2afjJOXvY4jrvv9dbzLDaDP6LHBZtS1cugc+9s6V86r0soZm+JDvpTDCGql
         +vLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=rU+PVWXGxbm8Wcv1t+NIsvEPEF01GAd8XhXNJLZ/y5Q=;
        fh=eSJHAoFNOdYsDj7gKKTW2Rj4cGqmVqZHwehqO+2rtmA=;
        b=GOHh5a9X5ZTgo/WKXEBOnGXGg7RKJY7A3Z6G9dnHHtGMw9gnHVQtZm9BP7G8sGhgrA
         VebxGYrqeTQScW68iRMPiNeU7h4+JuMlKR241/VBho3r5550w8dNdl0VQcg7LKzY2BFH
         iHqpDSziIV1GTvInwhfBDk3YbeUW8zUGBaUKEsJjLSdpXHGEX4Uy0SkC6I7BYVMPnzC6
         QRh2Gea4QUYdJNkRR1OAiRJamPHSN0zxHtM+KdSLX1QwBO4pHcxtddpqp7c5tFcSnAQk
         VW/15ouEYdIcxGHCt0VDQEtEJCBqmy8WZTTomwrlfeEKmGAiBRDmDVpZiQtWn+n63Liu
         +eZA==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782291553; x=1782896353; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rU+PVWXGxbm8Wcv1t+NIsvEPEF01GAd8XhXNJLZ/y5Q=;
        b=sXAIYvXIepUzBRrSrYnK8NdK2ffoP9nBCpeo3c6WwXY8LvTBhBSlxWo3bakXETOzdy
         z9RVS86pLVO56GdHpxUZd2so2y7jmv2rCcxBrb3oRLzp7+sBuUs7ApMW7wItcn44ZlRf
         IwrkmT+S3UgRkLidj7GGhFE11WBeuABxrT77n4TtxW2SC7nyvAotuvn/5I+DBYwHEFMl
         qi++DLjD+No2pSwbHe/W01p6S0UcLa1E89lKvvlTo5LUk9op9iRFhwcsR++ieQiPe8ei
         MCMcPlKMjPgLan3/Kb+AAn6QqaDsZYx/N99JHQ+mefTZADOkbiigRmi+5dsKsN7WdKTQ
         66aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782291553; x=1782896353;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rU+PVWXGxbm8Wcv1t+NIsvEPEF01GAd8XhXNJLZ/y5Q=;
        b=HfwsDpZr1gI7yoZTFtvMu5TKE729FMMD0a1KOt3L17boqzbZ9NJSY5fNiqkjVpxQ4l
         /DAycSn1+x9ri/oE7yvzfLgP4DvRyic89h0DmPuopbmxzJ+P9wvQA9FrUWmyJomSiPTj
         c/zqVjkjC+YXja5vLz2ZPRCVDe9YXy81YMhmb+YUPxnXQNVHuFjyJpsNzcxyg0/VVf9u
         /Ss2skkqAwdpyWWvwolk1t+MFfjPnNaFOr+8i8ybNJh4ci6fMTvhjo7Ti0XCgijg3qAj
         pSZCd6yEX6Fet1Ifz8sCCtstgYPRdHUcoIktJGyvEAMYst3aVWebaNTw8NC/0iEe9eQq
         KqgA==
X-Gm-Message-State: AOJu0YxSRGf4JkeHERRzIZJstUpdpWo/WLU8aAH6hqd0X1G0LrF489gr
	+RUY8P5GS1br2YYjRXRlk5RKSIzs32MXdo/BUQuOWPf/2lNB/7tIDQJ1SZR0qhrV0DVtjHm/QFw
	zBayU6RmWtBhc2JkjeIBLn6g/knu3107aqQ==
X-Gm-Gg: AfdE7ckVTaEbmBakIuSdKSeejb1tscCcD8taZaanAcvaMopiGog1467GoVTRbXxwKez
	nh6pe5/BAX20eA6ziTs96ZE9g5aqVZIooXD20cU5qM5NPcPlPh1o47AC7KWo34Qyf08zrL4T44/
	wY9Tsn+lE4BZiEHfyezaW6qw7UKUjNEmvioSfbhGSX0E0tHS3w4DJamwxACknzfP6/BL95ti90Z
	2TYOdgYlc+AqFd4vdpHudfjH21BScP3inaCmtMxAC6g3DSEvNczTBMNGxTTyGLW6ghCL9avaVBt
	RPZlCIFiFx5x3O1AR/6KG1TVbrHP
X-Received: by 2002:a05:6402:2349:b0:697:edf5:20d3 with SMTP id
 4fb4d7f45d1cf-697f3771086mr1276723a12.3.1782291551741; Wed, 24 Jun 2026
 01:59:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260623095532.159994-1-jacksonj2@kpit.com>
In-Reply-To: <20260623095532.159994-1-jacksonj2@kpit.com>
From: Jackson James <jackson.james9803@gmail.com>
Date: Wed, 24 Jun 2026 14:29:00 +0530
X-Gm-Features: AVVi8Cc5K6BXY3jFeqwL-QN9CkPu6cQnKGxBVhrkuOb5Fz2bK4htRNGjNCWUgAM
Message-ID: <CADuKNg6WnmnVZfKLREiATMffO9x1TTkbcm+ma1GbKS04prPcjw@mail.gmail.com>
Subject: Re: [meta-lts-collab][kirkstone][PATCH] spirv: Use STACK_ARRAY
 instead of NIR_VLA
To: yocto-patches@lists.yoctoproject.org
Cc: careers.myinfo@gmail.com
Content-Type: multipart/alternative; boundary="000000000000d3e9880654fc1689"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 24 Jun 2026 08:59:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4291

--000000000000d3e9880654fc1689
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi team,
Please ignore the patch. Will update patch commit message and send it again

Regards,
Jackson James

On Tue, 23 Jun, 2026, 3:26=E2=80=AFpm Jackson James, <jackson.james9803@gma=
il.com>
wrote:

> From: Shaik Moin <careers.myinfo@gmail.com>
>
> The number of fields comes from the shader, so it could be a value large
> enough that using alloca would be problematic.
>
> Signed-off-by: Shaik Moin <careers.myinfo@gmail.com>
> ---
>  ...0001-util-Move-STACK_ARRAY-into-util.patch |  83 ++++++++++++++
>  .../mesa/files/CVE-2026-40393.patch           | 103 ++++++++++++++++++
>  meta-oe/recipes-graphics/mesa/mesa_%.bbappend |   5 +
>  3 files changed, 191 insertions(+)
>  create mode 100644
> meta-oe/recipes-graphics/mesa/files/0001-util-Move-STACK_ARRAY-into-util.=
patch
>  create mode 100644
> meta-oe/recipes-graphics/mesa/files/CVE-2026-40393.patch
>  create mode 100644 meta-oe/recipes-graphics/mesa/mesa_%.bbappend
>
> diff --git
> a/meta-oe/recipes-graphics/mesa/files/0001-util-Move-STACK_ARRAY-into-uti=
l.patch
> b/meta-oe/recipes-graphics/mesa/files/0001-util-Move-STACK_ARRAY-into-uti=
l.patch
> new file mode 100644
> index 0000000..49aa1b0
> --- /dev/null
> +++
> b/meta-oe/recipes-graphics/mesa/files/0001-util-Move-STACK_ARRAY-into-uti=
l.patch
> @@ -0,0 +1,83 @@
> +From 8dfa16221058327dbfed11aafff963ac73334756 Mon Sep 17 00:00:00 2001
> +From: Shaik Moin <careers.myinfo@gmail.com>
> +Date: Fri, 19 Jun 2026 16:40:02 +0530
> +Subject: [PATCH] util: Move STACK_ARRAY into util
> +
> +It's useful for more than just Vulkan.
> +
> +Reference:
> +
> https://gitlab.freedesktop.org/mesa/mesa/-/commit/f43cff3728e58c377d1e03b=
13db62514217abfe1.patch
> +
> +Signed-off-by: Shaik Moin <careers.myinfo@gmail.com>
> +---
> + src/util/meson.build   |  1 +
> + src/util/stack_array.h | 45 ++++++++++++++++++++++++++++++++++++++++++
> + 2 files changed, 46 insertions(+)
> + create mode 100644 src/util/stack_array.h
> +
> +diff --git a/src/util/meson.build b/src/util/meson.build
> +index 6e77a2f..9c37972 100644
> +--- a/src/util/meson.build
> ++++ b/src/util/meson.build
> +@@ -110,6 +110,7 @@ files_mesa_util =3D files(
> +   'softfloat.h',
> +   'sparse_array.c',
> +   'sparse_array.h',
> ++  'stack_array.h',
> +   'string_buffer.c',
> +   'string_buffer.h',
> +   'strndup.h',
> +diff --git a/src/util/stack_array.h b/src/util/stack_array.h
> +new file mode 100644
> +index 0000000..e2133bd
> +--- /dev/null
> ++++ b/src/util/stack_array.h
> +@@ -0,0 +1,45 @@
> ++/*
> ++ * Copyright =C2=A9 2025 Collabora, Ltd.
> ++ *
> ++ * Permission is hereby granted, free of charge, to any person obtainin=
g
> a
> ++ * copy of this software and associated documentation files (the
> "Software"),
> ++ * to deal in the Software without restriction, including without
> limitation
> ++ * the rights to use, copy, modify, merge, publish, distribute,
> sublicense,
> ++ * and/or sell copies of the Software, and to permit persons to whom th=
e
> ++ * Software is furnished to do so, subject to the following conditions:
> ++ *
> ++ * The above copyright notice and this permission notice (including the
> next
> ++ * paragraph) shall be included in all copies or substantial portions o=
f
> the
> ++ * Software.
> ++ *
> ++ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> EXPRESS OR
> ++ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY,
> ++ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT
> SHALL
> ++ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
> OTHER
> ++ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> ARISING
> ++ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
> DEALINGS
> ++ * IN THE SOFTWARE.
> ++ */
> ++
> ++#include <stdlib.h>
> ++
> ++#ifndef UTIL_STACK_ARRAY_H
> ++#define UTIL_STACK_ARRAY_H
> ++
> ++#define STACK_ARRAY_SIZE 8
> ++
> ++/* Sometimes gcc may claim -Wmaybe-uninitialized for the stack array in
> some
> ++ * places it can't verify that when size is 0 nobody down the call chai=
n
> reads
> ++ * the array. Please don't try to fix it by zero-initializing the array
> here
> ++ * since it's used in a lot of different places. An "if (size =3D=3D 0)
> return;"
> ++ * may work for you.
> ++ */
> ++#define STACK_ARRAY(type, name, size) \
> ++   type _stack_##name[STACK_ARRAY_SIZE]; \
> ++   type *const name =3D \
> ++     ((size) <=3D STACK_ARRAY_SIZE ? _stack_##name : (type *)malloc((si=
ze)
> * sizeof(type)))
> ++
> ++#define STACK_ARRAY_FINISH(name) \
> ++   if (name !=3D _stack_##name) free(name)
> ++
> ++#endif /* UTIL_STACK_ARRAY_H */
> +--
> +2.34.1
> +
> diff --git a/meta-oe/recipes-graphics/mesa/files/CVE-2026-40393.patch
> b/meta-oe/recipes-graphics/mesa/files/CVE-2026-40393.patch
> new file mode 100644
> index 0000000..e35e5a4
> --- /dev/null
> +++ b/meta-oe/recipes-graphics/mesa/files/CVE-2026-40393.patch
> @@ -0,0 +1,103 @@
> +From e240e44e1967b9f605225ecddbf07f307952c814 Mon Sep 17 00:00:00 2001
> +From: Shaik Moin <careers.myinfo@gmail.com>
> +Date: Mon, 8 Jun 2026 12:21:41 +0530
> +Subject: [PATCH] spirv: Use STACK_ARRAY instead of NIR_VLA
> +
> +The number of fields comes from the shader, so it could be a value large
> +enough that using alloca would be problematic.
> +
> +Backport the fix for CVE-2026-40393
> +
> +CVE: CVE-2026-40393
> +
> +Upstream-Status: Backport [
> https://gitlab.freedesktop.org/mesa/mesa/-/commit/978fd42b4b7d1e9c0435ffa=
7e1a4d339cba9b76e
> ]
> +
> +Patch is refreshed based on code base.
> +
> +Fixes: 2a023f30a64 ("nir/spirv: Add basic support for types")
> +Reviewed-by: Caio Oliveira <caio.oliveira@intel.com>
> +Reviewed-by: Ryan Neph <ryanneph@google.com>
> +Reviewed-by: Lionel Landwerlin <lionel.g.landwerlin@intel.com>
> +Signed-off-by: Shaik Moin <moin.shaik@partner.bmwgroup.com>
> +---
> + src/compiler/spirv/spirv_to_nir.c | 18 ++++++++++++------
> + 1 file changed, 12 insertions(+), 6 deletions(-)
> +
> +diff --git a/src/compiler/spirv/spirv_to_nir.c
> b/src/compiler/spirv/spirv_to_nir.c
> +index 79e176a..68da937 100644
> +--- a/src/compiler/spirv/spirv_to_nir.c
> ++++ b/src/compiler/spirv/spirv_to_nir.c
> +@@ -26,7 +26,6 @@
> +  */
> +
> + #include "vtn_private.h"
> +-#include "nir/nir_vla.h"
> + #include "nir/nir_control_flow.h"
> + #include "nir/nir_constant_expressions.h"
> + #include "nir/nir_deref.h"
> +@@ -35,6 +34,7 @@
> + #include "util/format/u_format.h"
> + #include "util/u_math.h"
> + #include "util/u_string.h"
> ++#include "util/stack_array.h"
> +
> + #include <stdio.h>
> +
> +@@ -926,7 +926,7 @@ vtn_type_get_nir_type(struct vtn_builder *b, struct
> vtn_type *type,
> +       case vtn_base_type_struct: {
> +          bool need_new_struct =3D false;
> +          const uint32_t num_fields =3D type->length;
> +-         NIR_VLA(struct glsl_struct_field, fields, num_fields);
> ++         STACK_ARRAY(struct glsl_struct_field, fields, num_fields);
> +          for (unsigned i =3D 0; i < num_fields; i++) {
> +             fields[i] =3D *glsl_get_struct_field_data(type->type, i);
> +             const struct glsl_type *field_nir_type =3D
> +@@ -936,20 +936,25 @@ vtn_type_get_nir_type(struct vtn_builder *b, struc=
t
> vtn_type *type,
> +                need_new_struct =3D true;
> +             }
> +          }
> ++
> ++       const struct glsl_type *result;
> +          if (need_new_struct) {
> +             if (glsl_type_is_interface(type->type)) {
> +-               return glsl_interface_type(fields, num_fields,
> ++               result =3D glsl_interface_type(fields, num_fields,
> +                                           /* packing */ 0, false,
> +
>  glsl_get_type_name(type->type));
> +             } else {
> +-               return glsl_struct_type(fields, num_fields,
> ++               result =3D glsl_struct_type(fields, num_fields,
> +                                        glsl_get_type_name(type->type),
> +
> glsl_struct_type_is_packed(type->type));
> +             }
> +          } else {
> +             /* No changes, just pass it on */
> +-            return type->type;
> ++            result =3D type->type;
> +          }
> ++
> ++       STACK_ARRAY_FINISH(fields);
> ++       return result;
> +       }
> +
> +       case vtn_base_type_image:
> +@@ -1519,7 +1524,7 @@ vtn_handle_type(struct vtn_builder *b, SpvOp opcod=
e,
> +       val->type->offsets =3D ralloc_array(b, unsigned, num_fields);
> +       val->type->packed =3D false;
> +
> +-      NIR_VLA(struct glsl_struct_field, fields, count);
> ++      STACK_ARRAY(struct glsl_struct_field, fields, count);
> +       for (unsigned i =3D 0; i < num_fields; i++) {
> +          val->type->members[i] =3D vtn_get_type(b, w[i + 2]);
> +          const char *name =3D NULL;
> +@@ -1575,6 +1580,7 @@ vtn_handle_type(struct vtn_builder *b, SpvOp opcod=
e,
> +                                             name ? name : "struct",
> +                                             val->type->packed);
> +       }
> ++      STACK_ARRAY_FINISH(fields);
> +       break;
> +    }
> +
> +--
> +2.34.1
> +
> diff --git a/meta-oe/recipes-graphics/mesa/mesa_%.bbappend
> b/meta-oe/recipes-graphics/mesa/mesa_%.bbappend
> new file mode 100644
> index 0000000..553264a
> --- /dev/null
> +++ b/meta-oe/recipes-graphics/mesa/mesa_%.bbappend
> @@ -0,0 +1,5 @@
> +FILESEXTRAPATHS:prepend :=3D "${THISDIR}/files:"
> +
> +SRC_URI +=3D "file://CVE-2026-40393.patch \
> +            file://0001-util-Move-STACK_ARRAY-into-util.patch \
> +"
> --
> 2.34.1
>
>

--000000000000d3e9880654fc1689
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi team,<div dir=3D"auto">Please ignore the patch. Will u=
pdate patch commit message and send it again</div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto">Regards,</div><div dir=3D"auto">Jackson James</div></d=
iv><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" cl=
ass=3D"gmail_attr">On Tue, 23 Jun, 2026, 3:26=E2=80=AFpm Jackson James, &lt=
;<a href=3D"mailto:jackson.james9803@gmail.com">jackson.james9803@gmail.com=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">From: Shaik Moin &l=
t;<a href=3D"mailto:careers.myinfo@gmail.com" target=3D"_blank" rel=3D"nore=
ferrer">careers.myinfo@gmail.com</a>&gt;<br>
<br>
The number of fields comes from the shader, so it could be a value large<br=
>
enough that using alloca would be problematic.<br>
<br>
Signed-off-by: Shaik Moin &lt;<a href=3D"mailto:careers.myinfo@gmail.com" t=
arget=3D"_blank" rel=3D"noreferrer">careers.myinfo@gmail.com</a>&gt;<br>
---<br>
=C2=A0...0001-util-Move-STACK_ARRAY-into-util.patch |=C2=A0 83 ++++++++++++=
++<br>
=C2=A0.../mesa/files/CVE-2026-40393.patch=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| 103 ++++++++++++++++++<br>
=C2=A0meta-oe/recipes-graphics/mesa/mesa_%.bbappend |=C2=A0 =C2=A05 +<br>
=C2=A03 files changed, 191 insertions(+)<br>
=C2=A0create mode 100644 meta-oe/recipes-graphics/mesa/files/0001-util-Move=
-STACK_ARRAY-into-util.patch<br>
=C2=A0create mode 100644 meta-oe/recipes-graphics/mesa/files/CVE-2026-40393=
.patch<br>
=C2=A0create mode 100644 meta-oe/recipes-graphics/mesa/mesa_%.bbappend<br>
<br>
diff --git a/meta-oe/recipes-graphics/mesa/files/0001-util-Move-STACK_ARRAY=
-into-util.patch b/meta-oe/recipes-graphics/mesa/files/0001-util-Move-STACK=
_ARRAY-into-util.patch<br>
new file mode 100644<br>
index 0000000..49aa1b0<br>
--- /dev/null<br>
+++ b/meta-oe/recipes-graphics/mesa/files/0001-util-Move-STACK_ARRAY-into-u=
til.patch<br>
@@ -0,0 +1,83 @@<br>
+From 8dfa16221058327dbfed11aafff963ac73334756 Mon Sep 17 00:00:00 2001<br>
+From: Shaik Moin &lt;<a href=3D"mailto:careers.myinfo@gmail.com" target=3D=
"_blank" rel=3D"noreferrer">careers.myinfo@gmail.com</a>&gt;<br>
+Date: Fri, 19 Jun 2026 16:40:02 +0530<br>
+Subject: [PATCH] util: Move STACK_ARRAY into util<br>
+<br>
+It&#39;s useful for more than just Vulkan.<br>
+<br>
+Reference:<br>
+<a href=3D"https://gitlab.freedesktop.org/mesa/mesa/-/commit/f43cff3728e58=
c377d1e03b13db62514217abfe1.patch" rel=3D"noreferrer noreferrer" target=3D"=
_blank">https://gitlab.freedesktop.org/mesa/mesa/-/commit/f43cff3728e58c377=
d1e03b13db62514217abfe1.patch</a><br>
+<br>
+Signed-off-by: Shaik Moin &lt;<a href=3D"mailto:careers.myinfo@gmail.com" =
target=3D"_blank" rel=3D"noreferrer">careers.myinfo@gmail.com</a>&gt;<br>
+---<br>
+ src/util/meson.build=C2=A0 =C2=A0|=C2=A0 1 +<br>
+ src/util/stack_array.h | 45 ++++++++++++++++++++++++++++++++++++++++++<br=
>
+ 2 files changed, 46 insertions(+)<br>
+ create mode 100644 src/util/stack_array.h<br>
+<br>
+diff --git a/src/util/meson.build b/src/util/meson.build<br>
+index 6e77a2f..9c37972 100644<br>
+--- a/src/util/meson.build<br>
++++ b/src/util/meson.build<br>
+@@ -110,6 +110,7 @@ files_mesa_util =3D files(<br>
+=C2=A0 =C2=A0&#39;softfloat.h&#39;,<br>
+=C2=A0 =C2=A0&#39;sparse_array.c&#39;,<br>
+=C2=A0 =C2=A0&#39;sparse_array.h&#39;,<br>
++=C2=A0 &#39;stack_array.h&#39;,<br>
+=C2=A0 =C2=A0&#39;string_buffer.c&#39;,<br>
+=C2=A0 =C2=A0&#39;string_buffer.h&#39;,<br>
+=C2=A0 =C2=A0&#39;strndup.h&#39;,<br>
+diff --git a/src/util/stack_array.h b/src/util/stack_array.h<br>
+new file mode 100644<br>
+index 0000000..e2133bd<br>
+--- /dev/null<br>
++++ b/src/util/stack_array.h<br>
+@@ -0,0 +1,45 @@<br>
++/*<br>
++ * Copyright =C2=A9 2025 Collabora, Ltd.<br>
++ *<br>
++ * Permission is hereby granted, free of charge, to any person obtaining =
a<br>
++ * copy of this software and associated documentation files (the &quot;So=
ftware&quot;),<br>
++ * to deal in the Software without restriction, including without limitat=
ion<br>
++ * the rights to use, copy, modify, merge, publish, distribute, sublicens=
e,<br>
++ * and/or sell copies of the Software, and to permit persons to whom the<=
br>
++ * Software is furnished to do so, subject to the following conditions:<b=
r>
++ *<br>
++ * The above copyright notice and this permission notice (including the n=
ext<br>
++ * paragraph) shall be included in all copies or substantial portions of =
the<br>
++ * Software.<br>
++ *<br>
++ * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KI=
ND, EXPRESS OR<br>
++ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILIT=
Y,<br>
++ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.=C2=A0 IN NO EVEN=
T SHALL<br>
++ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR O=
THER<br>
++ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISIN=
G<br>
++ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DE=
ALINGS<br>
++ * IN THE SOFTWARE.<br>
++ */<br>
++<br>
++#include &lt;stdlib.h&gt;<br>
++<br>
++#ifndef UTIL_STACK_ARRAY_H<br>
++#define UTIL_STACK_ARRAY_H<br>
++<br>
++#define STACK_ARRAY_SIZE 8<br>
++<br>
++/* Sometimes gcc may claim -Wmaybe-uninitialized for the stack array in s=
ome<br>
++ * places it can&#39;t verify that when size is 0 nobody down the call ch=
ain reads<br>
++ * the array. Please don&#39;t try to fix it by zero-initializing the arr=
ay here<br>
++ * since it&#39;s used in a lot of different places. An &quot;if (size =
=3D=3D 0) return;&quot;<br>
++ * may work for you.<br>
++ */<br>
++#define STACK_ARRAY(type, name, size) \<br>
++=C2=A0 =C2=A0type _stack_##name[STACK_ARRAY_SIZE]; \<br>
++=C2=A0 =C2=A0type *const name =3D \<br>
++=C2=A0 =C2=A0 =C2=A0((size) &lt;=3D STACK_ARRAY_SIZE ? _stack_##name : (t=
ype *)malloc((size) * sizeof(type)))<br>
++<br>
++#define STACK_ARRAY_FINISH(name) \<br>
++=C2=A0 =C2=A0if (name !=3D _stack_##name) free(name)<br>
++<br>
++#endif /* UTIL_STACK_ARRAY_H */<br>
+-- <br>
+2.34.1<br>
+<br>
diff --git a/meta-oe/recipes-graphics/mesa/files/CVE-2026-40393.patch b/met=
a-oe/recipes-graphics/mesa/files/CVE-2026-40393.patch<br>
new file mode 100644<br>
index 0000000..e35e5a4<br>
--- /dev/null<br>
+++ b/meta-oe/recipes-graphics/mesa/files/CVE-2026-40393.patch<br>
@@ -0,0 +1,103 @@<br>
+From e240e44e1967b9f605225ecddbf07f307952c814 Mon Sep 17 00:00:00 2001<br>
+From: Shaik Moin &lt;<a href=3D"mailto:careers.myinfo@gmail.com" target=3D=
"_blank" rel=3D"noreferrer">careers.myinfo@gmail.com</a>&gt;<br>
+Date: Mon, 8 Jun 2026 12:21:41 +0530<br>
+Subject: [PATCH] spirv: Use STACK_ARRAY instead of NIR_VLA<br>
+<br>
+The number of fields comes from the shader, so it could be a value large<b=
r>
+enough that using alloca would be problematic.<br>
+<br>
+Backport the fix for CVE-2026-40393<br>
+<br>
+CVE: CVE-2026-40393<br>
+<br>
+Upstream-Status: Backport [<a href=3D"https://gitlab.freedesktop.org/mesa/=
mesa/-/commit/978fd42b4b7d1e9c0435ffa7e1a4d339cba9b76e" rel=3D"noreferrer n=
oreferrer" target=3D"_blank">https://gitlab.freedesktop.org/mesa/mesa/-/com=
mit/978fd42b4b7d1e9c0435ffa7e1a4d339cba9b76e</a>]<br>
+<br>
+Patch is refreshed based on code base.<br>
+<br>
+Fixes: 2a023f30a64 (&quot;nir/spirv: Add basic support for types&quot;)<br=
>
+Reviewed-by: Caio Oliveira &lt;<a href=3D"mailto:caio.oliveira@intel.com" =
target=3D"_blank" rel=3D"noreferrer">caio.oliveira@intel.com</a>&gt;<br>
+Reviewed-by: Ryan Neph &lt;<a href=3D"mailto:ryanneph@google.com" target=
=3D"_blank" rel=3D"noreferrer">ryanneph@google.com</a>&gt;<br>
+Reviewed-by: Lionel Landwerlin &lt;<a href=3D"mailto:lionel.g.landwerlin@i=
ntel.com" target=3D"_blank" rel=3D"noreferrer">lionel.g.landwerlin@intel.co=
m</a>&gt;<br>
+Signed-off-by: Shaik Moin &lt;<a href=3D"mailto:moin.shaik@partner.bmwgrou=
p.com" target=3D"_blank" rel=3D"noreferrer">moin.shaik@partner.bmwgroup.com=
</a>&gt;<br>
+---<br>
+ src/compiler/spirv/spirv_to_nir.c | 18 ++++++++++++------<br>
+ 1 file changed, 12 insertions(+), 6 deletions(-)<br>
+<br>
+diff --git a/src/compiler/spirv/spirv_to_nir.c b/src/compiler/spirv/spirv_=
to_nir.c<br>
+index 79e176a..68da937 100644<br>
+--- a/src/compiler/spirv/spirv_to_nir.c<br>
++++ b/src/compiler/spirv/spirv_to_nir.c<br>
+@@ -26,7 +26,6 @@<br>
+=C2=A0 */<br>
+ <br>
+ #include &quot;vtn_private.h&quot;<br>
+-#include &quot;nir/nir_vla.h&quot;<br>
+ #include &quot;nir/nir_control_flow.h&quot;<br>
+ #include &quot;nir/nir_constant_expressions.h&quot;<br>
+ #include &quot;nir/nir_deref.h&quot;<br>
+@@ -35,6 +34,7 @@<br>
+ #include &quot;util/format/u_format.h&quot;<br>
+ #include &quot;util/u_math.h&quot;<br>
+ #include &quot;util/u_string.h&quot;<br>
++#include &quot;util/stack_array.h&quot;<br>
+ <br>
+ #include &lt;stdio.h&gt;<br>
+ <br>
+@@ -926,7 +926,7 @@ vtn_type_get_nir_type(struct vtn_builder *b, struct vt=
n_type *type,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0case vtn_base_type_struct: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool need_new_struct =3D false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const uint32_t num_fields =3D type-&gt;=
length;<br>
+-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NIR_VLA(struct glsl_struct_field, field=
s, num_fields);<br>
++=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0STACK_ARRAY(struct glsl_struct_field, f=
ields, num_fields);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (unsigned i =3D 0; i &lt; num_field=
s; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fields[i] =3D *glsl_get_st=
ruct_field_data(type-&gt;type, i);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct glsl_type *fi=
eld_nir_type =3D<br>
+@@ -936,20 +936,25 @@ vtn_type_get_nir_type(struct vtn_builder *b, struct =
vtn_type *type,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 need_new_struct =
=3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
++<br>
++=C2=A0 =C2=A0 =C2=A0 =C2=A0const struct glsl_type *result;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (need_new_struct) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (glsl_type_is_interface=
(type-&gt;type)) {<br>
+-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return glsl_interf=
ace_type(fields, num_fields,<br>
++=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0result =3D glsl_in=
terface_type(fields, num_fields,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0/* packing */ 0, false,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0glsl_get_type_name(type-&gt;type));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
+-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return glsl_struct=
_type(fields, num_fields,<br>
++=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0result =3D glsl_st=
ruct_type(fields, num_fields,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 glsl_get=
_type_name(type-&gt;type),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 glsl_str=
uct_type_is_packed(type-&gt;type));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* No changes, just pass i=
t on */<br>
+-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return type-&gt;type;<br>
++=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D type-&gt;type;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
++<br>
++=C2=A0 =C2=A0 =C2=A0 =C2=A0STACK_ARRAY_FINISH(fields);<br>
++=C2=A0 =C2=A0 =C2=A0 =C2=A0return result;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+ <br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0case vtn_base_type_image:<br>
+@@ -1519,7 +1524,7 @@ vtn_handle_type(struct vtn_builder *b, SpvOp opcode,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0val-&gt;type-&gt;offsets =3D ralloc_array(b, un=
signed, num_fields);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0val-&gt;type-&gt;packed =3D false;<br>
+ <br>
+-=C2=A0 =C2=A0 =C2=A0 NIR_VLA(struct glsl_struct_field, fields, count);<br=
>
++=C2=A0 =C2=A0 =C2=A0 STACK_ARRAY(struct glsl_struct_field, fields, count)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0for (unsigned i =3D 0; i &lt; num_fields; i++) =
{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val-&gt;type-&gt;members[i] =3D vtn_get=
_type(b, w[i + 2]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *name =3D NULL;<br>
+@@ -1575,6 +1580,7 @@ vtn_handle_type(struct vtn_builder *b, SpvOp opcode,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0name ? name : &quot;struct&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0val-&gt;type-&gt;packed);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
++=C2=A0 =C2=A0 =C2=A0 STACK_ARRAY_FINISH(fields);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 }<br>
+ <br>
+-- <br>
+2.34.1<br>
+<br>
diff --git a/meta-oe/recipes-graphics/mesa/mesa_%.bbappend b/meta-oe/recipe=
s-graphics/mesa/mesa_%.bbappend<br>
new file mode 100644<br>
index 0000000..553264a<br>
--- /dev/null<br>
+++ b/meta-oe/recipes-graphics/mesa/mesa_%.bbappend<br>
@@ -0,0 +1,5 @@<br>
+FILESEXTRAPATHS:prepend :=3D &quot;${THISDIR}/files:&quot;<br>
+<br>
+SRC_URI +=3D &quot;file://CVE-2026-40393.patch \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 file://0001-util-Move-STACK_ARRA=
Y-into-util.patch \<br>
+&quot;<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div>

--000000000000d3e9880654fc1689--

