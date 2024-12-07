Return-Path: <grembeter@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25FEE7717B
	for <webhook@archiver.kernel.org>; Sat,  7 Dec 2024 08:08:56 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
 by mx.groups.io with SMTP id smtpd.web10.56763.1733558926886389864
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 07 Dec 2024 00:08:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Y2JdssY+;
 spf=pass (domain: gmail.com, ip: 209.85.218.46, mailfrom: grembeter@gmail.com)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa647af6804so137261066b.1
        for <yocto-patches@lists.yoctoproject.org>; Sat, 07 Dec 2024 00:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733558925; x=1734163725; darn=lists.yoctoproject.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YSfCkmyTsx4pg+mn4/1Kga8Vu63RrPiwHko1P8BXbiA=;
        b=Y2JdssY+u+pvRt/V12Gthk59xTjZJFePPJWi1RdiepCt0/CJ77y5aANAMffX4za6Zb
         vGpHZns/HrKO082Yl+gfHkEooKwAgJOpQPLJt3QFrTGsAzJtkRx+mmcOBkxNwdhS3NV6
         AleR6GfkQMa2/BzwY8vpJw9/RVqWzcXDaFR/LW6pL2hIoXTcoHDBCMZZunxY2JXG/Ico
         557KrUPsLRzo4cp2S4+fcP0ojCdgqPNooi6VyDZPNF1jZFSGzVvJQioRujoQdSm2jm55
         OzEx4SBus3VXY6cORZ4/lGsuEZRy4GNeYdCstKVA2AofyVvRzABfH7f5/4SeNhXjlTAo
         N+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733558925; x=1734163725;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YSfCkmyTsx4pg+mn4/1Kga8Vu63RrPiwHko1P8BXbiA=;
        b=FAi6pGgwrBsJfwKiTV27gwNcJE70+1G0L6K3KtPC0R3xSC+/bDKWvCxvUVwF3aEgy6
         0ElOZnzEy55YUDhZXmrkv+NPqBBvNt9oipBVymLl85v2ZX4H0ECU0jsnitqzN5MdOlQq
         GRagy3zCVN2jJrmX7/yNvlEdSJ449+nkkwhThEpFIlcPnWhOMQ1Cs+rLCXp4kdomzgcC
         +zGZ/Y+hYq4I/RBjsXVo31+Ax5nNiz4U1o5Q+Hcc4fiKF1MtDYBKNmtY48E1I6xSxSng
         u5DNnCwy1utbP5+DLm0woF7YysSh36vbRRysbYs+2eNO4xkOyiuinhbSq1/6j10HNs3A
         S/6w==
X-Gm-Message-State: AOJu0YxKb6H0ltmNKiM6Yv5eurwzoArwtbpQAgI0cIB8AMfZwrRB92Wp
	gol5kh5oRjZFG8oIqVIfTUdWchB6haI3IXl2K2JYymyMDYic/AWrfYdyZyD1aRi2O/prQIOUup9
	fMzksaS6PMcQgmn8DSwke3OMmpmjKBA==
X-Gm-Gg: ASbGnctgfIMguy+n0Y1eVfeoEy+QOjZ331Pk0cyWd6DYRx58Pq4GsNij4rqHDmiGrQT
	09J2EfkUGmt16ohk2BBoj7IYvtHPooxbCGqVEf9YTERqsldU9BOtyAgxre05mMLs=
X-Google-Smtp-Source: AGHT+IGof3veqOaws8nHt0gePdYXpdM7nLqnQMDBy1ouik0uOcAuNTNyE+Sd17KSxCXW4VA6UoAmqg3qhQ66xHS6hdM=
X-Received: by 2002:a17:906:1da9:b0:aa6:50ee:d44c with SMTP id
 a640c23a62f3a-aa650eed58cmr96081266b.15.1733558924535; Sat, 07 Dec 2024
 00:08:44 -0800 (PST)
MIME-Version: 1.0
References: <180649620E332603.19665@lists.yoctoproject.org>
In-Reply-To: <180649620E332603.19665@lists.yoctoproject.org>
From: grygorii tertychnyi <grembeter@gmail.com>
Date: Sat, 7 Dec 2024 09:08:33 +0100
Message-ID: <CAGFuAuw2ByKHpwE2gUFjRLzTrD1B4pB2m6nXCo6tpbDeHOW4=g@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-security][PATCH] dm-verity-img.bbclass: add DM_VERITY_SETUP_ARGS
To: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="000000000000e4f9db0628a9a351"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 07 Dec 2024 08:08:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/866

--000000000000e4f9db0628a9a351
Content-Type: text/plain; charset="UTF-8"

ping

On Sat, 9 Nov 2024 at 12:29, gr embeter via lists.yoctoproject.org
<grembeter=gmail.com@lists.yoctoproject.org> wrote:

> Useful to pass additional arguments to veritysetup, for example
> '--no-superblock' to make system less vulnerable to certain types of
> attacks and data maniputaion on the disk.
>
> Signed-off-by: Grygorii Tertychnyi <grembeter@gmail.com>
> ---
>  classes/dm-verity-img.bbclass | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/classes/dm-verity-img.bbclass b/classes/dm-verity-img.bbclass
> index 7f79548353b0..9a3a97ec6c26 100644
> --- a/classes/dm-verity-img.bbclass
> +++ b/classes/dm-verity-img.bbclass
> @@ -46,6 +46,9 @@ DM_VERITY_IMAGE_HASH_BLOCK_SIZE ?= "4096"
>  # Should we store the hash data on a separate device/partition?
>  DM_VERITY_SEPARATE_HASH ?= "0"
>
> +# Additional arguments for veritysetup
> +DM_VERITY_SETUP_ARGS ?= ""
> +
>  # These are arch specific.  We could probably intelligently auto-assign
> these?
>  # Take x86-64 values as defaults. No impact on functionality currently.
>  # See SD_GPT_ROOT_X86_64 and SD_GPT_ROOT_X86_64_VERITY in the spec.
> @@ -146,6 +149,7 @@ verity_setup() {
>      cp -a $INPUT $OUTPUT
>
>      SETUP_ARGS=" \
> +        ${DM_VERITY_SETUP_ARGS} \
>          --data-block-size=${DM_VERITY_IMAGE_DATA_BLOCK_SIZE} \
>          --hash-block-size=${DM_VERITY_IMAGE_HASH_BLOCK_SIZE} \
>          $HASH_OFFSET format $OUTPUT $OUTPUT_HASH \
> --
> 2.39.5
>
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#791):
> https://lists.yoctoproject.org/g/yocto-patches/message/791
> Mute This Topic: https://lists.yoctoproject.org/mt/109479783/4926536
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe:
> https://lists.yoctoproject.org/g/yocto-patches/leave/13733539/4926536/1016200526/xyzzy
> [grembeter@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>
>

--000000000000e4f9db0628a9a351
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">ping</div><div><br><div class=3D"gmail_quote"><div dir=3D=
"ltr" class=3D"gmail_attr">On Sat, 9 Nov 2024 at 12:29, gr embeter via <a h=
ref=3D"http://lists.yoctoproject.org">lists.yoctoproject.org</a> &lt;grembe=
ter=3D<a href=3D"mailto:gmail.com@lists.yoctoproject.org">gmail.com@lists.y=
octoproject.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:so=
lid;padding-left:1ex;border-left-color:rgb(204,204,204)">Useful to pass add=
itional arguments to veritysetup, for example<br>
&#39;--no-superblock&#39; to make system less vulnerable to certain types o=
f<br>
attacks and data maniputaion on the disk.<br>
<br>
Signed-off-by: Grygorii Tertychnyi &lt;<a href=3D"mailto:grembeter@gmail.co=
m" target=3D"_blank">grembeter@gmail.com</a>&gt;<br>
---<br>
=C2=A0classes/dm-verity-img.bbclass | 4 ++++<br>
=C2=A01 file changed, 4 insertions(+)<br>
<br>
diff --git a/classes/dm-verity-img.bbclass b/classes/dm-verity-img.bbclass<=
br>
index 7f79548353b0..9a3a97ec6c26 100644<br>
--- a/classes/dm-verity-img.bbclass<br>
+++ b/classes/dm-verity-img.bbclass<br>
@@ -46,6 +46,9 @@ DM_VERITY_IMAGE_HASH_BLOCK_SIZE ?=3D &quot;4096&quot;<br>
=C2=A0# Should we store the hash data on a separate device/partition?<br>
=C2=A0DM_VERITY_SEPARATE_HASH ?=3D &quot;0&quot;<br>
<br>
+# Additional arguments for veritysetup<br>
+DM_VERITY_SETUP_ARGS ?=3D &quot;&quot;<br>
+<br>
=C2=A0# These are arch specific.=C2=A0 We could probably intelligently auto=
-assign these?<br>
=C2=A0# Take x86-64 values as defaults. No impact on functionality currentl=
y.<br>
=C2=A0# See SD_GPT_ROOT_X86_64 and SD_GPT_ROOT_X86_64_VERITY in the spec.<b=
r>
@@ -146,6 +149,7 @@ verity_setup() {<br>
=C2=A0 =C2=A0 =C2=A0cp -a $INPUT $OUTPUT<br>
<br>
=C2=A0 =C2=A0 =C2=A0SETUP_ARGS=3D&quot; \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ${DM_VERITY_SETUP_ARGS} \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--data-block-size=3D${DM_VERITY_IMAGE_DAT=
A_BLOCK_SIZE} \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--hash-block-size=3D${DM_VERITY_IMAGE_HAS=
H_BLOCK_SIZE} \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$HASH_OFFSET format $OUTPUT $OUTPUT_HASH =
\<br>
-- <br>
2.39.5<br>
<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#791): <a href=3D"https://lists.yoctoproject.org/g/yocto=
-patches/message/791" rel=3D"noreferrer" target=3D"_blank">https://lists.yo=
ctoproject.org/g/yocto-patches/message/791</a><br>
Mute This Topic: <a href=3D"https://lists.yoctoproject.org/mt/109479783/492=
6536" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/m=
t/109479783/4926536</a><br>
Group Owner: <a href=3D"mailto:yocto-patches%2Bowner@lists.yoctoproject.org=
" target=3D"_blank">yocto-patches+owner@lists.yoctoproject.org</a><br>
Unsubscribe: <a href=3D"https://lists.yoctoproject.org/g/yocto-patches/leav=
e/13733539/4926536/1016200526/xyzzy" rel=3D"noreferrer" target=3D"_blank">h=
ttps://lists.yoctoproject.org/g/yocto-patches/leave/13733539/4926536/101620=
0526/xyzzy</a> [<a href=3D"mailto:grembeter@gmail.com" target=3D"_blank">gr=
embeter@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
<br>
</blockquote></div></div>

--000000000000e4f9db0628a9a351--

