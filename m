Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB960C43458
	for <webhook@archiver.kernel.org>; Wed,  8 Jul 2026 14:56:51 +0000 (UTC)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10388.1783522611254992362
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 08 Jul 2026 07:56:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=W7VuyqbW;
 spf=pass (domain: gmail.com, ip: 209.85.128.180, mailfrom: jpewhacker@gmail.com)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-81d2b54fa70so11745077b3.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 08 Jul 2026 07:56:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783522610; cv=none;
        d=google.com; s=arc-20260327;
        b=Vs83BPmPuB7H0tudZOCT/Ck39n9+WX7P9GN/jNMkTZzkVg1udnMzzkSkwpshIEASir
         aXTDytOENbMy5V8oGFORGo2hTQWQnXoL3RRyuFvsDXgkDTzTeg8SQaeS5fXTV8hk54Sm
         nss3ByDaQhoobVyrarIn5wOfd7aqMK+2+Ry740+LKwwYxroTFvZtgvyqXUiaeCiNtQyG
         Wj6MC8KyjYGLWmdKQ1xl4KQoPkW4ls1S+2flmPnkc1/W9kfO3o9wz5+uwFa21j3oSZuC
         YLVUo7rr3nBFfJnkxIehJxan7nVg7yJAgVBpVU2NJHNSZ33aiT9ZWKc2KbmHFerg3y/t
         cI4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2iFQsHXCMHqO63nPIfpE0x9r9txVt5UYxA6epdGcQcw=;
        fh=ZH3wtczcUaw/qCH+nsmdcFXP/O47krpttXtPWPBQK6s=;
        b=Gg2ULzfbzAfWFIuIwfeYkfgYSy/tFs6fhE0Uskv/5nHkAe+H3MJa4pBzovMp895Qie
         GwJUMuj1bdyx4nA8lgywRclf4d8YgwV8u53/dziPsPrPiPBwdOFsOv27DxTBdpTzojIf
         SeU9nNucvmc/zY8dVhvQPKfge9cgG9A1Hf6vtRqDCueYsEZdRUbfGlLkntoLl7NPeZdV
         Qk3YvrANVfW4Rl94Std3wx+R8CzxOgrytvx/nLmeDv2wlArCQl1w8RfvNnbSKrjdqfFv
         jUEv7VSdyCUg37OGFLSNAY20itcbzf6WZKoXtorXQlyvAuC+0zMye6UrteoQRA2jv93j
         G+hA==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783522610; x=1784127410; darn=lists.yoctoproject.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2iFQsHXCMHqO63nPIfpE0x9r9txVt5UYxA6epdGcQcw=;
        b=W7VuyqbWIdvMLphdpkcV95JuYBJmwE6E5hoHobOGESlcOjb5qtYvXEEAidLa285N6e
         OcfsttPLAm2AEUffhdkamaliP07xwRp7+zSeLMxTU9rDBHymh6sNzq0STtFpjbRuYtbc
         Ajt5owigP/quVa3zxhSr4eroyrHfS6WtdoRXAXwmTwEV5LrBbnvs2BNYBA78QXNtL+yG
         c+0m7Va5OSlkAPrDmI+M85ugMBKswZ1zE6JmvNbu5k6i6BP04Kry5Mzdoai7JaE42J/X
         yfPD8h0SWPiuOmX3SgUZbd7+TLHva2rR7SkXfQVaJzwrWUbC4OQhW+/eA0T2D1fqsX4U
         DCoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783522610; x=1784127410;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2iFQsHXCMHqO63nPIfpE0x9r9txVt5UYxA6epdGcQcw=;
        b=XPPTzjvO6dU90zrmxTTHfjIdNksYZqa7lfiaIziWHtF8G3y+vLIq9Ko5CCZJWYcxKZ
         /gOeHgro/pM6ott4WqJ0czLdpo9nss0mE4qepMmiNtJZSQPHVbloW4nz4W7TLrm7DGPm
         j+858eWbF6KxlMTgdSOGiUAlNXErZc3XSMvQv0HkKYGFaOnlJ782SsNfN2PntB8/a1VM
         c5G2yNXwcF5IzPCC826GNaRhOS1AJIvMKq3VGtxQUykABMkzvAOkdGwpNmXAXAePbV4/
         f2M7BqXdvmVgArfoxB+FF+oECB3pSe1tlHMIql7j/8uQSTrxS0GXSuSZnKtTkS/IG1qS
         yssA==
X-Gm-Message-State: AOJu0Yw/i9AVA4VIQKgLjO7GFe5NTaB3x5zLKOa5jKI+h3xjVMKS+kid
	eUKxmt0jV8HnYCdI9MPqgvPNz+6/JFW/TtVatxTC4+COgHtEg1rF+rh+8qeAmcsWchbeDE2EMnh
	oVCnkeYYPKTXZgS3S7olDjICKMZjkzR8=
X-Gm-Gg: AfdE7clWbUlfcndrb61MrC79SA5AiZWIasJyIg8oDq52vtFvW7+JbQBGnPAW8YhgPmO
	LURf2vwjh4voXZe00TIt6XXLNC7W1QXmGcpfRMtWD+oe7mqLHioJSB7cFAnFlGHTR1jUcKADnI1
	0iSbS9g94nfibdN4nx7QUduH4RtMVNeA6ZsRUqEvtg80DFpOr0z0QBfYrHwuMnUdEguY2jzYz1g
	xiWDUDQGy13fRTq5gWdbCAs7b6Isg2g+qSCumzfW44jxSn+8szpq4bxJNf10qfGiOC+crPelGZj
	3RZiDOpgHvyElFnpoRcNSw==
X-Received: by 2002:a05:690c:9b11:b0:80f:34b4:ae with SMTP id
 00721157ae682-81dc12efa68mr22429937b3.47.1783522605502; Wed, 08 Jul 2026
 07:56:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260708144551.2741360-1-ross.sweng@gmail.com>
In-Reply-To: <20260708144551.2741360-1-ross.sweng@gmail.com>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Wed, 8 Jul 2026 08:56:31 -0600
X-Gm-Features: AVVi8CeW493mtCR2Pk6c3l7KnvloP5GsDVYG5p7wFHaEdf6XT6QZXmqBQGOSlC8
Message-ID: <CAJdd5GacXK_J47BaVU6RE_S-Rn-St4AqtebccYFKPCz1BRm0ng@mail.gmail.com>
Subject: Re: [meta-mingw] [PATCH] toolchain-scripts-mingw32: add /usr/share/pkgconfig
To: Ross Stutterheim <ross.sweng@gmail.com>
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="0000000000005992f306561ab75d"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 08 Jul 2026 14:56:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4455

--0000000000005992f306561ab75d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 8, 2026 at 8:46=E2=80=AFAM Ross Stutterheim <ross.sweng@gmail.c=
om>
wrote:

> poky commit e0bcf333df8bccbc7aca39048423d97247454c5e added
>

FYI: poky repo is no longer used so I updated the commit message to OE core
1bea760f3f462fdcc3eefc0d8597688d61447ddd for you

Otherwise, LGTM; I'll run it through the test suite just to be sure


> /usr/share/pkgconfig to PKG_CONFIG_PATH back in 2016. Add here so SDKs
> generated for windows can find the same packages as SDKs for linux
> when using pkg-config after sourcing the environment-setup script.
>
> Signed-off-by: Ross Stutterheim <ross.sweng@gmail.com>
> ---
>  classes/toolchain-scripts-mingw32.bbclass | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/classes/toolchain-scripts-mingw32.bbclass
> b/classes/toolchain-scripts-mingw32.bbclass
> index 8cb426a..ee53bf8 100644
> --- a/classes/toolchain-scripts-mingw32.bbclass
> +++ b/classes/toolchain-scripts-mingw32.bbclass
> @@ -25,7 +25,7 @@ toolchain_create_sdk_env_script:sdkmingw32 () {
>         done
>         echo "set
> PATH=3D$sdkpathnative$bindir;$sdkpathnative$bindir/../${HOST_SYS}/bin;$sd=
kpathnative$bindir/${TARGET_SYS}"$EXTRAPATH';%PATH%'
> >> $script
>         echo 'set PKG_CONFIG_SYSROOT_DIR=3D%SDKTARGETSYSROOT%' >> $script
> -       echo 'set PKG_CONFIG_PATH=3D%SDKTARGETSYSROOT%'"$libdir"'/pkgconf=
ig'
> >> $script
> +       echo 'set
> PKG_CONFIG_PATH=3D%SDKTARGETSYSROOT%'"$libdir"'/pkgconfig;%SDKTARGETSYSRO=
OT%'"$prefix"'/share/pkgconfig'
> >> $script
>         echo 'set
> CONFIG_SITE=3D%SDKROOT%/site-config-'"${multimach_target_sys}" >> $script
>         echo "set OECORE_NATIVE_SYSROOT=3D$sdkpathnative" >> $script
>         echo 'set OECORE_TARGET_SYSROOT=3D%SDKTARGETSYSROOT%' >> $script
> --
> 2.54.0
>
>

--0000000000005992f306561ab75d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jul 8, =
2026 at 8:46=E2=80=AFAM Ross Stutterheim &lt;<a href=3D"mailto:ross.sweng@g=
mail.com">ross.sweng@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">poky commit e0bcf333df8bccbc7aca39048423d9724=
7454c5e added<br></blockquote><div><br></div><div>FYI: poky repo is no long=
er used so I updated the commit message to OE core 1bea760f3f462fdcc3eefc0d=
8597688d61447ddd for you</div><div><br></div><div>Otherwise, LGTM; I&#39;ll=
 run it through the test suite just to be sure</div><div>=C2=A0</div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">
/usr/share/pkgconfig to PKG_CONFIG_PATH back in 2016. Add here so SDKs<br>
generated for windows can find the same packages as SDKs for linux<br>
when using pkg-config after sourcing the environment-setup script.<br>
<br>
Signed-off-by: Ross Stutterheim &lt;<a href=3D"mailto:ross.sweng@gmail.com"=
 target=3D"_blank">ross.sweng@gmail.com</a>&gt;<br>
---<br>
=C2=A0classes/toolchain-scripts-mingw32.bbclass | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/classes/toolchain-scripts-mingw32.bbclass b/classes/toolchain-=
scripts-mingw32.bbclass<br>
index 8cb426a..ee53bf8 100644<br>
--- a/classes/toolchain-scripts-mingw32.bbclass<br>
+++ b/classes/toolchain-scripts-mingw32.bbclass<br>
@@ -25,7 +25,7 @@ toolchain_create_sdk_env_script:sdkmingw32 () {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 done<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 echo &quot;set PATH=3D$sdkpathnative$bindir;$sd=
kpathnative$bindir/../${HOST_SYS}/bin;$sdkpathnative$bindir/${TARGET_SYS}&q=
uot;$EXTRAPATH&#39;;%PATH%&#39; &gt;&gt; $script<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 echo &#39;set PKG_CONFIG_SYSROOT_DIR=3D%SDKTARG=
ETSYSROOT%&#39; &gt;&gt; $script<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0echo &#39;set PKG_CONFIG_PATH=3D%SDKTARGETSYSRO=
OT%&#39;&quot;$libdir&quot;&#39;/pkgconfig&#39; &gt;&gt; $script<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0echo &#39;set PKG_CONFIG_PATH=3D%SDKTARGETSYSRO=
OT%&#39;&quot;$libdir&quot;&#39;/pkgconfig;%SDKTARGETSYSROOT%&#39;&quot;$pr=
efix&quot;&#39;/share/pkgconfig&#39; &gt;&gt; $script<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 echo &#39;set CONFIG_SITE=3D%SDKROOT%/site-conf=
ig-&#39;&quot;${multimach_target_sys}&quot; &gt;&gt; $script<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 echo &quot;set OECORE_NATIVE_SYSROOT=3D$sdkpath=
native&quot; &gt;&gt; $script<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 echo &#39;set OECORE_TARGET_SYSROOT=3D%SDKTARGE=
TSYSROOT%&#39; &gt;&gt; $script<br>
-- <br>
2.54.0<br>
<br>
</blockquote></div></div>

--0000000000005992f306561ab75d--

