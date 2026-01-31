Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7434AE7C6E9
	for <webhook@archiver.kernel.org>; Sat, 31 Jan 2026 20:40:40 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17080.1769892032926501063
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 31 Jan 2026 12:40:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=bSHWAkOc;
 spf=pass (domain: snapchat.com, ip: 209.85.128.51, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-480142406b3so23336945e9.1
        for <yocto-patches@lists.yoctoproject.org>; Sat, 31 Jan 2026 12:40:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769892031; cv=none;
        d=google.com; s=arc-20240605;
        b=GmuYtJ8Bu0512PiB4yBDKcdWo9WmoFdBtTEecYHeSvWS38Qreny1CljPlTfGEpic6I
         lcviwt3Bl0BqJ61neZyQ01YECrTRdkYx832kKzd26U66q6wfNb1CnrSd1eZiSn7B5a1i
         lcH6Gz8DOv9OBO4HMtAb2B0lHJK5yE3JBJcXz33UgdTpNj50uDqRyw9C0HTZsmrzZjKG
         d1CWavFVI9ZE1Jidv3dzwnlWAd/YcwKCIb2gYcAHM446YhybWj4VwjaMP3H8tF2tgiR5
         hOGDvfA/7BH1+56SgcIJNG+EDvxEwud3uehs4vNCu51EbF3vi7kQD6hGKGAQT6ZYfg5K
         thSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=szOwKb7CpSn8VoEcndg81txKHAWQ2yM18LLCtAaZ08U=;
        fh=moagCLbVVFQO5kw1aLdWVpJz+dpYgsdIWNCHzBu4K0w=;
        b=FiNxcmsYZeowesJNFhi7FqG1PqyO83sMwVp8BFDACRWo4jHYKc974PwiwowKt/9AkQ
         CtKeN53ck3REDILd2dKa5OJohvmDipvqAoTiMcoDuEN9xCwgr5DGl9eKZP3fxnyJv6UY
         BJCvV9ccp0PXgwgyEkTUoqwRVkXP+JVPFFWTFv+8O93zjWDXOggKSnyt1X5PnYAf6Aty
         zBsBJKFUeQo8mktl2V/DDvhgVGhRco2tk90Y0rYyk3zQwrX+utAKrfpQVp54HpCM+g25
         A7iB9ej253IEib/L6ZhkAOSpdCkJ+xxsviMr/lJpXJSiWTmDE5TBCgK95Xx6EED7D3dj
         xoZg==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1769892031; x=1770496831; darn=lists.yoctoproject.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=szOwKb7CpSn8VoEcndg81txKHAWQ2yM18LLCtAaZ08U=;
        b=bSHWAkOcUNbLD+hpog4c/Q3rKhzhVbvH///8V7ZZHF3SP9tOJsDwvhLV/+bs0wefJV
         w5AGKqj99AorcneKYQ4KFdqCySEuAUbirQ8OLehl9azoUakxOC9nDqkSFfZNyIaMW8Lo
         EdUWsvFX1F4Al+MC2VGfURuRfAxD1teSvlaTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769892031; x=1770496831;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=szOwKb7CpSn8VoEcndg81txKHAWQ2yM18LLCtAaZ08U=;
        b=NBcKZdpb974tKpA/EPiz8vD15MF1RqbA0QvsMyJYNqjbaR1mAY3jo8F5UXIIQScXj6
         9LZB8SZfJGzMDKUahDyY6mjZb8akVorust8YMF6nJ4+zTOPkgamx6SukJ67ZhwbMOra1
         DnByyLdCrQA5snnVKqPiO/Cm+hFQAkLs8lzhKLEbvuegiWSL2iY8l3pFZT6Lw6rq+FEM
         HHUqzCThP0Uh2aJ1E2+rvOtL8k7xdoL13PS+e54MrlG1CHEn/YryMitCXQvd8Nj6Ft0q
         jmPVHCbrMePaD5aHKV2KOrCjfd4jUbObODXJgA0TziECYRKEMCJlt9mpz/LlMtEigSQW
         oydw==
X-Gm-Message-State: AOJu0YwYvS4H0A1Tofw+BM+yOnVQ/pFljTkO7dd+9pOVzsXb8f0OCRHT
	ShdYAhd0ve7AZzTsscOx5ZJNF1mFxx03er8PhUkMlwkEQSzJ2RRcU16ioA5c5LntO+MTZUR4yJt
	Z6/8X4jkfKrHin9eYdeQ6IYMYVGMlYCuJVnHBiJqPE1uIH1B6FSic9C0/CQ==
X-Gm-Gg: AZuq6aJJC8hlkLKjlKjlF7gLVTerEA3RPd4UqB01+QcDuPfN+6Prz8GotxYuWpap5T0
	x4rNvYwK/i0iu4JOGWL7FgxpLHhOgYqY/ejJTjKqZmEx2L/S4kTxQ6nfVCxyhNgrYjxnjNBJslg
	0xa/KQGxunK9r4L25//vCirSoqYhGvn8Y/4kYTTGnN3fQaZHQO6XgrUUpPCkea8Bt+XduFWhxsp
	q8DqGuDTjCXucP8xffks5z35mX73TeOZIHq8oansJ0ZEoKTFrLTyUkUo+AWOdEmEhHB5Fc5PlX4
	t4EoKlaIaFOOK3T5T0U85SeoNqI=
X-Received: by 2002:a05:600c:8a17:20b0:480:25ae:9993 with SMTP id
 5b1f17b1804b1-482db47ce2emr63251875e9.20.1769892030679; Sat, 31 Jan 2026
 12:40:30 -0800 (PST)
MIME-Version: 1.0
References: <20260128063648.1422-1-dev@qinc.tv>
In-Reply-To: <20260128063648.1422-1-dev@qinc.tv>
From: Etienne Cordonnier <ecordonnier@snap.com>
Date: Sat, 31 Jan 2026 21:40:19 +0100
X-Gm-Features: AZwV_QgU-HjTpKNnx_3Oy2uihEeRwtbvPzQ5xJAZ7wHNK1SeuUvDcpj8C8QR9E4
Message-ID: <CAHUKmYba6Xi4sMfxMdu-ZhBc-HC41jAf27gaTRE+6bV-SoUFAg@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-darwin][PATCH 1/3] add hfsprogs recipe
To: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="000000000000c7ab6a0649b5191b"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 31 Jan 2026 20:40:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3159

--000000000000c7ab6a0649b5191b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric,
thanks for the patch! There are minor issues which could be improved:
- do_compile is redundant with the default definition of base.bbclass. The
file Makefile does exist in the repo, even though it's Makefile.lnx which
is compiled, thus this code should work:
```
base_do_compile() {
if [ -e Makefile -o -e makefile -o -e GNUmakefile ]; then
oe_runmake || die "make failed"
else
```
- the recipe resets the value of EXTRA_OEMAKE instead of appending, so it
will remove the default value which contains PARALLEL_MAKE
- Makefile.lnx overrides CC and sets it to "gcc", thus this recipe uses the
native compiler even when calling "bitbake hfsprogs". I think we don't need
the target version anyway, but in this case it's slightly cleaner to use
"inherit native" and/or rename the recipe to hfsprogs-native.bb, rather
than BBCLASSEXTEND =3D "native". This way yocto will throw an error if tryi=
ng
to compile the target version.

On Wed, Jan 28, 2026 at 7:36=E2=80=AFAM Eric L. Hernes via lists.yoctoproje=
ct.org
<dev=3Dqinc.tv@lists.yoctoproject.org> wrote:

> hfsprogs is used to create the dmg image file for macOS
>
> Signed-off-by: Eric L. Hernes <dev@qinc.tv>
> ---
>  recipes-support/hfsprogs/hfsprogs_git.bb | 35 ++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 recipes-support/hfsprogs/hfsprogs_git.bb
>
> diff --git a/recipes-support/hfsprogs/hfsprogs_git.bb
> b/recipes-support/hfsprogs/hfsprogs_git.bb
> new file mode 100644
> index 0000000..17ac0d7
> --- /dev/null
> +++ b/recipes-support/hfsprogs/hfsprogs_git.bb
> @@ -0,0 +1,35 @@
> +SUMMARY =3D "HFS+ filesystem utilities for Linux"
> +DESCRIPTION =3D "Apple's HFS+ filesystem utilities (mkfs.hfsplus,
> fsck.hfsplus) \
> +adapted to work on Linux systems. Based on Apple's diskdev-cmds source
> code."
> +HOMEPAGE =3D "https://github.com/Artoria2e5/hfsprogs "
> +
> +LICENSE =3D "APSL-2.0"
> +LIC_FILES_CHKSUM =3D "file://README.md;md5=3Dea27fd14a7e575753270cc5527d=
29023"
> +
> +SRCREV =3D "47e4944b2abc57f5d8456ab399671a06031bbfb5"
> +SRC_URI =3D "git://
> github.com/elhernes/hfsprogs.git;branch=3Dmaster;protocol=3Dhttps"
> +
> +S =3D "${WORKDIR}/git"
> +
> +DEPENDS =3D "openssl libbsd"
> +
> +EXTRA_OEMAKE =3D "-f Makefile.lnx"
> +
> +CFLAGS +=3D "-DDEBUG_BUILD=3D0 -D_FILE_OFFSET_BITS=3D64 -DLINUX=3D1 -DBS=
D=3D1
> -I${S}/include"
> +
> +do_compile() {
> +    oe_runmake ${EXTRA_OEMAKE}
> +}
> +
> +do_install() {
> +    install -d ${D}${sbindir}
> +    install -d ${D}${mandir}/man8
> +
> +    install -m 0755 ${S}/newfs_hfs.tproj/newfs_hfs
> ${D}${sbindir}/mkfs.hfsplus
> +    install -m 0755 ${S}/fsck_hfs.tproj/fsck_hfs
> ${D}${sbindir}/fsck.hfsplus
> +
> +    install -m 0644 ${S}/newfs_hfs.tproj/newfs_hfs.8
> ${D}${mandir}/man8/mkfs.hfsplus.8
> +    install -m 0644 ${S}/fsck_hfs.tproj/fsck_hfs.8
> ${D}${mandir}/man8/fsck.hfsplus.8
> +}
> +
> +BBCLASSEXTEND =3D "native"
> --
> 2.50.1 (Apple Git-155)
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#3125):
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject=
.org_g_yocto-2Dpatches_message_3125&d=3DDwIFAg&c=3DncDTmphkJTvjIDPh0hpF_4vC=
HvabgGkICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3D0Dz=
CSR8qWxxpgrmRYjdHYOexdcVZ7rR7Pe41uSFJx1JivDrG9-AInrM96jCMA0BK&s=3DUQDb7SZqw=
d_C-BJ0ZA50rv28q2vdoWNYRwz9Meb2nMU&e=3D
> Mute This Topic:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject=
.org_mt_117504010_7048771&d=3DDwIFAg&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC=
2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3D0DzCSR8qWxxpg=
rmRYjdHYOexdcVZ7rR7Pe41uSFJx1JivDrG9-AInrM96jCMA0BK&s=3DMKp4m2KXl4jA-dpaqk2=
k5p95UuB5lMOcKYpZSwtV40U&e=3D
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject=
.org_g_yocto-2Dpatches_leave_13184993_7048771_1814342232_xyzzy&d=3DDwIFAg&c=
=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRi=
h1DULJTKUkSGa66m67E&m=3D0DzCSR8qWxxpgrmRYjdHYOexdcVZ7rR7Pe41uSFJx1JivDrG9-A=
InrM96jCMA0BK&s=3DcRSleh1mz5Xu5Ftb31h5O98Ql3Qddujv4mYtk7th0IA&e=3D
> [ecordonnier@snap.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>
>

--000000000000c7ab6a0649b5191b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Eric,<br>thanks for the patch! There are minor issues w=
hich could be improved:<br>- do_compile is redundant with the default defin=
ition of base.bbclass. The file Makefile does exist in the repo, even thoug=
h it&#39;s Makefile.lnx which is compiled, thus this code should work:<br>`=
``<br>base_do_compile() {<br>	if [ -e Makefile -o -e makefile -o -e GNUmake=
file ]; then<br>		oe_runmake || die &quot;make failed&quot;<br>	else<br>```=
<br>- the recipe resets the value of EXTRA_OEMAKE instead of appending, so =
it will remove the default value which contains PARALLEL_MAKE<br>- Makefile=
.lnx overrides CC and sets it to &quot;gcc&quot;, thus this recipe uses the=
 native compiler even when calling &quot;bitbake hfsprogs&quot;. I think we=
 don&#39;t need the target version anyway, but in this case it&#39;s slight=
ly cleaner to use &quot;inherit native&quot; and/or rename the recipe to <a=
 href=3D"http://hfsprogs-native.bb">hfsprogs-native.bb</a>, rather than BBC=
LASSEXTEND =3D &quot;native&quot;. This way yocto will throw an error if tr=
ying to compile the target version.</div><br><div class=3D"gmail_quote gmai=
l_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jan 28, 20=
26 at 7:36=E2=80=AFAM Eric L. Hernes via <a href=3D"http://lists.yoctoproje=
ct.org">lists.yoctoproject.org</a> &lt;dev=3D<a href=3D"mailto:qinc.tv@list=
s.yoctoproject.org">qinc.tv@lists.yoctoproject.org</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">hfsprogs is used to creat=
e the dmg image file for macOS<br>
<br>
Signed-off-by: Eric L. Hernes &lt;<a href=3D"mailto:dev@qinc.tv" target=3D"=
_blank">dev@qinc.tv</a>&gt;<br>
---<br>
=C2=A0recipes-support/hfsprogs/<a href=3D"http://hfsprogs_git.bb" rel=3D"no=
referrer" target=3D"_blank">hfsprogs_git.bb</a> | 35 ++++++++++++++++++++++=
++<br>
=C2=A01 file changed, 35 insertions(+)<br>
=C2=A0create mode 100644 recipes-support/hfsprogs/<a href=3D"http://hfsprog=
s_git.bb" rel=3D"noreferrer" target=3D"_blank">hfsprogs_git.bb</a><br>
<br>
diff --git a/recipes-support/hfsprogs/<a href=3D"http://hfsprogs_git.bb" re=
l=3D"noreferrer" target=3D"_blank">hfsprogs_git.bb</a> b/recipes-support/hf=
sprogs/<a href=3D"http://hfsprogs_git.bb" rel=3D"noreferrer" target=3D"_bla=
nk">hfsprogs_git.bb</a><br>
new file mode 100644<br>
index 0000000..17ac0d7<br>
--- /dev/null<br>
+++ b/recipes-support/hfsprogs/<a href=3D"http://hfsprogs_git.bb" rel=3D"no=
referrer" target=3D"_blank">hfsprogs_git.bb</a><br>
@@ -0,0 +1,35 @@<br>
+SUMMARY =3D &quot;HFS+ filesystem utilities for Linux&quot;<br>
+DESCRIPTION =3D &quot;Apple&#39;s HFS+ filesystem utilities (mkfs.hfsplus,=
 fsck.hfsplus) \<br>
+adapted to work on Linux systems. Based on Apple&#39;s diskdev-cmds source=
 code.&quot;<br>
+HOMEPAGE =3D &quot;<a href=3D"https://github.com/Artoria2e5/hfsprogs" rel=
=3D"noreferrer" target=3D"_blank">https://github.com/Artoria2e5/hfsprogs</a=
> &quot;<br>
+<br>
+LICENSE =3D &quot;APSL-2.0&quot;<br>
+LIC_FILES_CHKSUM =3D &quot;file://README.md;md5=3Dea27fd14a7e575753270cc55=
27d29023&quot;<br>
+<br>
+SRCREV =3D &quot;47e4944b2abc57f5d8456ab399671a06031bbfb5&quot;<br>
+SRC_URI =3D &quot;git://<a href=3D"http://github.com/elhernes/hfsprogs.git=
;branch=3Dmaster;protocol=3Dhttps" rel=3D"noreferrer" target=3D"_blank">git=
hub.com/elhernes/hfsprogs.git;branch=3Dmaster;protocol=3Dhttps</a>&quot;<br=
>
+<br>
+S =3D &quot;${WORKDIR}/git&quot;<br>
+<br>
+DEPENDS =3D &quot;openssl libbsd&quot;<br>
+<br>
+EXTRA_OEMAKE =3D &quot;-f Makefile.lnx&quot;<br>
+<br>
+CFLAGS +=3D &quot;-DDEBUG_BUILD=3D0 -D_FILE_OFFSET_BITS=3D64 -DLINUX=3D1 -=
DBSD=3D1 -I${S}/include&quot;<br>
+<br>
+do_compile() {<br>
+=C2=A0 =C2=A0 oe_runmake ${EXTRA_OEMAKE}<br>
+}<br>
+<br>
+do_install() {<br>
+=C2=A0 =C2=A0 install -d ${D}${sbindir}<br>
+=C2=A0 =C2=A0 install -d ${D}${mandir}/man8<br>
+<br>
+=C2=A0 =C2=A0 install -m 0755 ${S}/newfs_hfs.tproj/newfs_hfs ${D}${sbindir=
}/mkfs.hfsplus<br>
+=C2=A0 =C2=A0 install -m 0755 ${S}/fsck_hfs.tproj/fsck_hfs ${D}${sbindir}/=
fsck.hfsplus<br>
+<br>
+=C2=A0 =C2=A0 install -m 0644 ${S}/newfs_hfs.tproj/newfs_hfs.8 ${D}${mandi=
r}/man8/mkfs.hfsplus.8<br>
+=C2=A0 =C2=A0 install -m 0644 ${S}/fsck_hfs.tproj/fsck_hfs.8 ${D}${mandir}=
/man8/fsck.hfsplus.8<br>
+}<br>
+<br>
+BBCLASSEXTEND =3D &quot;native&quot;<br>
-- <br>
2.50.1 (Apple Git-155)<br>
<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#3125): <a href=3D"https://urldefense.proofpoint.com/v2/=
url?u=3Dhttps-3A__lists.yoctoproject.org_g_yocto-2Dpatches_message_3125&amp=
;d=3DDwIFAg&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhk=
bNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3D0DzCSR8qWxxpgrmRYjdHYOexdc=
VZ7rR7Pe41uSFJx1JivDrG9-AInrM96jCMA0BK&amp;s=3DUQDb7SZqwd_C-BJ0ZA50rv28q2vd=
oWNYRwz9Meb2nMU&amp;e=3D" rel=3D"noreferrer" target=3D"_blank">https://urld=
efense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject.org_g_yocto-2=
Dpatches_message_3125&amp;d=3DDwIFAg&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgG=
kICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3D0=
DzCSR8qWxxpgrmRYjdHYOexdcVZ7rR7Pe41uSFJx1JivDrG9-AInrM96jCMA0BK&amp;s=3DUQD=
b7SZqwd_C-BJ0ZA50rv28q2vdoWNYRwz9Meb2nMU&amp;e=3D</a> <br>
Mute This Topic: <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dht=
tps-3A__lists.yoctoproject.org_mt_117504010_7048771&amp;d=3DDwIFAg&amp;c=3D=
ncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsR=
ih1DULJTKUkSGa66m67E&amp;m=3D0DzCSR8qWxxpgrmRYjdHYOexdcVZ7rR7Pe41uSFJx1JivD=
rG9-AInrM96jCMA0BK&amp;s=3DMKp4m2KXl4jA-dpaqk2k5p95UuB5lMOcKYpZSwtV40U&amp;=
e=3D" rel=3D"noreferrer" target=3D"_blank">https://urldefense.proofpoint.co=
m/v2/url?u=3Dhttps-3A__lists.yoctoproject.org_mt_117504010_7048771&amp;d=3D=
DwIFAg&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonV=
uMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3D0DzCSR8qWxxpgrmRYjdHYOexdcVZ7rR=
7Pe41uSFJx1JivDrG9-AInrM96jCMA0BK&amp;s=3DMKp4m2KXl4jA-dpaqk2k5p95UuB5lMOcK=
YpZSwtV40U&amp;e=3D</a> <br>
Group Owner: <a href=3D"mailto:yocto-patches%2Bowner@lists.yoctoproject.org=
" target=3D"_blank">yocto-patches+owner@lists.yoctoproject.org</a><br>
Unsubscribe: <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dhttps-=
3A__lists.yoctoproject.org_g_yocto-2Dpatches_leave_13184993_7048771_1814342=
232_xyzzy&amp;d=3DDwIFAg&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdi=
w&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3D0DzCSR8qWxxpg=
rmRYjdHYOexdcVZ7rR7Pe41uSFJx1JivDrG9-AInrM96jCMA0BK&amp;s=3DcRSleh1mz5Xu5Ft=
b31h5O98Ql3Qddujv4mYtk7th0IA&amp;e=3D" rel=3D"noreferrer" target=3D"_blank"=
>https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject.=
org_g_yocto-2Dpatches_leave_13184993_7048771_1814342232_xyzzy&amp;d=3DDwIFA=
g&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGR=
fPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3D0DzCSR8qWxxpgrmRYjdHYOexdcVZ7rR7Pe41=
uSFJx1JivDrG9-AInrM96jCMA0BK&amp;s=3DcRSleh1mz5Xu5Ftb31h5O98Ql3Qddujv4mYtk7=
th0IA&amp;e=3D</a>=C2=A0 [<a href=3D"mailto:ecordonnier@snap.com" target=3D=
"_blank">ecordonnier@snap.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
<br>
</blockquote></div>

--000000000000c7ab6a0649b5191b--

