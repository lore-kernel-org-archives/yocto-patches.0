Return-Path: <bruce.ashfield@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77ACCFD355
	for <webhook@archiver.kernel.org>; Mon, 24 Nov 2025 19:36:53 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.53.1764013011322544133
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 24 Nov 2025 11:36:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=coUIsUlk;
 spf=pass (domain: gmail.com, ip: 209.85.214.174, mailfrom: bruce.ashfield@gmail.com)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-297e982506fso63809805ad.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 24 Nov 2025 11:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764013011; x=1764617811; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jp4Fju8R/UgOw5+FtIchq818op5INq4OGH8nZzYCeT0=;
        b=coUIsUlkgDvtMv/W0XNULy/VEqxLPWa+Ydcg6c8Gih4SSFvI0aVzGik/27R+qBOjD2
         0d1Y0SDrtSZ9FCJEshe4+OYqyQEnYAlwbJgSicH23LbT3ylmpWAFMAPU7dMqRgVOAQ7A
         m8jwr0p2QHprOYUxPEFnITY5DEqgt31S61nLOAUXuqYqGTQWwLpuuShMn+XGyDcwG9XB
         TqLROEAsHIfCJdQi8nyeLhr+HQ2jl984C5Ejb6+4yry7o3A8C8TWLKg3UPAmI+1Y2CeQ
         XpeGpIWToh681XpgfZlLNU3u2aD2eq2hXFsaIZhVsuWFQThWVdD97eQMXtaJReuh7LuR
         OC+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764013011; x=1764617811;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jp4Fju8R/UgOw5+FtIchq818op5INq4OGH8nZzYCeT0=;
        b=D7KfZeBnw+56vzteISg5RjOuuc3v9Eky83ShqdESn33mq83wvzGj7JyZuTMcYg5gNe
         0GBO+p5FRjb1lNfS3yzF6M3/NG21g6Q7hHwQQ28TDP7cR4p1ICacop2qj6BaniMlXIH/
         COo91xvPew6zfrG2J8KCjd6xIx8sNqpyL45jEzjZuvnXfW4ugQLq+luLhTrVt11+aFDu
         KQqA2O9ZtOE9w70f2EzcAyZduirapW0jJdrqcZqVD+EtQHjY8whT2ykV0vHepGxOh9Q1
         TnNh6C6YQnWphfCtriDgldZ7cId67uZwJcJyZmaneKmkK2fGKov8mcvS8fYkJutxcHJU
         1Opg==
X-Gm-Message-State: AOJu0YyEZXZ6imYMq10IbT7sWcsjMZkniFbXsIEon7G4MHmZ98bgibPz
	X5viamgUenluuntALmc3+HrF8erGiTnGmMDBzklL/WQPF14pAM+uSxV+HqsgBwQjVt4gfBvodqV
	ggpMBdk3HokIlZ28RUBMnTLtURAzPmXM=
X-Gm-Gg: ASbGncsk7OLNm7WEEyNG4MEkEa7WQzAe/DMV6H/r/FQRtaOaxXbi0o/4GKo2k9tudCe
	PDVqSblZtukxeIateN+E5EIGZX+bR1sZ9jLH9sf6wxxDtZ9nXgKUChe6VHUlkWnWx0ML6mkhQA+
	LXIQdPzsonuK70EvHB1iO1wU+9RoTv8MAdImJQcy5D84OdchqiL/Oo6Toch7MlKpnOn8MjzpadC
	T9vT1IElLMWOa5FGOG9PSwo/ymnv8cBnsneY4V9nsLpj2FbJyTFUNXKYYHviPfZWGyE4x89
X-Google-Smtp-Source: AGHT+IFqgWfdEDZly5lXkzXqV6suEAlrnBsgagngttc1Rq22wYY3nyuDADN+fUTV+pNKaNV+xqBfb/kLMW+frY0SiXA=
X-Received: by 2002:a17:90b:5143:b0:343:66e2:5f9b with SMTP id
 98e67ed59e1d1-34733f15d4fmr13078023a91.24.1764013010738; Mon, 24 Nov 2025
 11:36:50 -0800 (PST)
MIME-Version: 1.0
References: <20251124183534.870124-1-ross.burton@arm.com>
In-Reply-To: <20251124183534.870124-1-ross.burton@arm.com>
From: Bruce Ashfield <bruce.ashfield@gmail.com>
Date: Mon, 24 Nov 2025 14:36:39 -0500
X-Gm-Features: AWmQ_blh1MoUd3hJdR3NM_sdedNldKDjNpxuOODQi6tV1ZdnmqBvFkVFccYRGPM
Message-ID: <CADkTA4N00z1Eg1A7FrHT2rq1eJX042jwA2gFoAqf_+xuYZAcHA@mail.gmail.com>
Subject: Re: [PATCH kernel-module-hello-world 1/2] hello-world: some cleanups
To: Ross Burton <ross.burton@arm.com>
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="000000000000e2604606445c48a8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 24 Nov 2025 19:36:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2705

--000000000000e2604606445c48a8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Acked-by: Bruce Ashfield <bruce.ashfield@gmail.com>

On Mon, Nov 24, 2025 at 1:35=E2=80=AFPM Ross Burton <ross.burton@arm.com> w=
rote:

> No need to include linux/init.h as module.h does this.
>
> Set the author to a real name for clarity.
>
> Print the filename of the module to verify that path remapping is
> working if specified.
>
> Fix a typo in the comments.
>
> Signed-off-by: Ross Burton <ross.burton@arm.com>
> ---
>  hello-world.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/hello-world.c b/hello-world.c
> index 8ca2dc6..9c22cde 100644
> --- a/hello-world.c
> +++ b/hello-world.c
> @@ -7,27 +7,26 @@
>   *
>   *
>   */
> -#include <linux/init.h>
>  #include <linux/module.h>
>
>
>  /* See module.h for additional #defines you may want to customize*/
>  MODULE_LICENSE("Dual MIT/GPL"); /* See module.h for acceptable options *=
/
> -MODULE_AUTHOR("Homer Simpson");
> +MODULE_AUTHOR("Mark Asselstine");
>  MODULE_DESCRIPTION("A hello-world kernel module");
>  MODULE_VERSION("0.1");
>
>  /* Initialize the module, called when first loaded */
>  static int __init hello_world_init(void) {
>    /* print "Hello World" to the dmesg on module load */
> -  printk(KERN_INFO "Hello World\n");
> +  printk(KERN_INFO "Hello World from " __FILE__ "\n");
>
>    return 0;
>  }
>
>  /* Last call before module unload, complete any cleanup */
>  static void __exit hello_world_exit(void) {
> -  /* print "Goodby World" to the dmesg on module unload */
> +  /* print "Goodbye World" to the dmesg on module unload */
>    printk(KERN_INFO "Goodbye World\n");
>  }
>
> --
> 2.43.0
>
>

--=20
- Thou shalt not follow the NULL pointer, for chaos and madness await thee
at its end
- "Use the force Harry" - Gandalf, Star Trek II

--000000000000e2604606445c48a8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-size:small">Ack=
ed-by: Bruce Ashfield &lt;<a href=3D"mailto:bruce.ashfield@gmail.com">bruce=
.ashfield@gmail.com</a>&gt;</div></div><br><div class=3D"gmail_quote gmail_=
quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Nov 24, 2025=
 at 1:35=E2=80=AFPM Ross Burton &lt;<a href=3D"mailto:ross.burton@arm.com">=
ross.burton@arm.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">No need to include linux/init.h as module.h does this.<b=
r>
<br>
Set the author to a real name for clarity.<br>
<br>
Print the filename of the module to verify that path remapping is<br>
working if specified.<br>
<br>
Fix a typo in the comments.<br>
<br>
Signed-off-by: Ross Burton &lt;<a href=3D"mailto:ross.burton@arm.com" targe=
t=3D"_blank">ross.burton@arm.com</a>&gt;<br>
---<br>
=C2=A0hello-world.c | 7 +++----<br>
=C2=A01 file changed, 3 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/hello-world.c b/hello-world.c<br>
index 8ca2dc6..9c22cde 100644<br>
--- a/hello-world.c<br>
+++ b/hello-world.c<br>
@@ -7,27 +7,26 @@<br>
=C2=A0 *<br>
=C2=A0 *<br>
=C2=A0 */<br>
-#include &lt;linux/init.h&gt;<br>
=C2=A0#include &lt;linux/module.h&gt;<br>
<br>
<br>
=C2=A0/* See module.h for additional #defines you may want to customize*/<b=
r>
=C2=A0MODULE_LICENSE(&quot;Dual MIT/GPL&quot;); /* See module.h for accepta=
ble options */<br>
-MODULE_AUTHOR(&quot;Homer Simpson&quot;);<br>
+MODULE_AUTHOR(&quot;Mark Asselstine&quot;);<br>
=C2=A0MODULE_DESCRIPTION(&quot;A hello-world kernel module&quot;);<br>
=C2=A0MODULE_VERSION(&quot;0.1&quot;);<br>
<br>
=C2=A0/* Initialize the module, called when first loaded */<br>
=C2=A0static int __init hello_world_init(void) {<br>
=C2=A0 =C2=A0/* print &quot;Hello World&quot; to the dmesg on module load *=
/<br>
-=C2=A0 printk(KERN_INFO &quot;Hello World\n&quot;);<br>
+=C2=A0 printk(KERN_INFO &quot;Hello World from &quot; __FILE__ &quot;\n&qu=
ot;);<br>
<br>
=C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
=C2=A0/* Last call before module unload, complete any cleanup */<br>
=C2=A0static void __exit hello_world_exit(void) {<br>
-=C2=A0 /* print &quot;Goodby World&quot; to the dmesg on module unload */<=
br>
+=C2=A0 /* print &quot;Goodbye World&quot; to the dmesg on module unload */=
<br>
=C2=A0 =C2=A0printk(KERN_INFO &quot;Goodbye World\n&quot;);<br>
=C2=A0}<br>
<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature">- Thou shalt not follow the NULL pointer, for chaos and madness a=
wait thee at its end<br>- &quot;Use the force Harry&quot; - Gandalf, Star T=
rek II<br><br></div>

--000000000000e2604606445c48a8--

