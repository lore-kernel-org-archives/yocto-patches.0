Return-Path: <ukleinek@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2255410F284E
	for <webhook@archiver.kernel.org>; Fri, 27 Mar 2026 16:33:54 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.77602.1774629228039409751
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 27 Mar 2026 09:33:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=zgbK7iBb;
 spf=pass (domain: baylibre.com, ip: 209.85.128.53, mailfrom: ukleinek@baylibre.com)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-486fc4725f0so21612975e9.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 27 Mar 2026 09:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774629226; x=1775234026; darn=lists.yoctoproject.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nDaNZGh6TOp+EidZM5yxoD1usWA3BHpw+3eyY+Ln9KU=;
        b=zgbK7iBbp3C5lq512CttD9zWFCUaOi/kYlJ0ajwYOlUw7219R5YEdVlntXgOggJmpp
         D4OBCTJbq9qy43JLz0LIhmOU71ifrIMkiagIQTJ4mFuzFkwcZD1dpqN4qgYYKHleWGHH
         vT3pxxal+tvJ8Fb+eFIg00TgIXLyub2r3mwtfi2XGwgGhVPcWQb9jqAxLI04xdkyIIy6
         GZYBrGupLgRBFFSoUHdQP29/beXL/njeTQC26UqOocyf9fkuLsrmeiGZOCtqZyzgzwAv
         9YxCz5KND8e/+HFgPjFg08UUFHDtisQdjDPkrRZk8V7tdZ/tH0ZYAL+o5aqp8ACrnRFd
         P9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774629226; x=1775234026;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nDaNZGh6TOp+EidZM5yxoD1usWA3BHpw+3eyY+Ln9KU=;
        b=PfICJbEZV8uRAg+s4IwFn+HJf59cScca78WWBHPURcbtNkaq/4VqQlNd2HvEKrCWc5
         JrXOwzYefI0Q29jyE6+qYwsJNM+A8Y3qo0EzePD4MVBHMvOMgRHQ/lYAs9sxE1gUPODr
         eEZttuk6uJlL+iGih2Km8+cspiIKwupLHOQMrq+a1ZtLbnLWpTjxNUfjtTZHIVO8h2jn
         Y0oEfhae8b7GEBzOTLJqV/ZYPynLEZNKBj4DDsvQ4GZeG6kFWPMvAgfPwbfix7gtPlp4
         zqlvIcfkEz0sxmss3BZDmxveN7F6bgN0pVVEvB36sl73ZN8x2WDyspn9RZcHaU01TuZW
         mlVw==
X-Forwarded-Encrypted: i=1; AJvYcCUr8k7M1pR6Fv/wbeQn6Q2+hLQwSvD9AZZlabi56d1FYDCTwHiJXU44wZqlM0UT+wlV0CrPexf/DlN3tovz@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YzwlebCMc3itgZ8eDSN47OFGML08Kk0C4G9hp0eJ81f6KNnYzIb
	1969gwkVpC9F2VgIr/uO4m/UZQkXsm6jfbur/LwbZyTvpXd0ori0nnR0/F/axPJkLHs=
X-Gm-Gg: ATEYQzz1VzwxQYDpuDqrabrbhKxSCyPVL8cayu+dBWKkHch9KowlNubPnIUDjyrsOtP
	PQTC0x3u5CNOeHXrEQF2mJJDw11mzJXXneJsqgZK+pJanW74FEnRu5LKB5x7OMfoOqNEeVkeGU/
	zU4o5zvm1ujy3xOVFUToVgB0+/CD9/WA3VQDLv/rmNQeEPI7lByf4YToS3HUCzS5/V+VBYDlzaU
	GIN4vwGuKTbo/YLD0te3FpwiJsuf4sPylFms8QjrKL6XEEW5hO2OwS9pO8RmBsWcPvOtpaBfvbC
	Dkq80xFsWfGiOFNOtQ1oIYQX5C/A47oVpIAoByFQDD3TC1CIyZhaEXj8o0pBTU1farH+Up6fgOW
	2GN/W5frIHGLdL9dVlH9eBtozThHDka4+MTwqzhd8DyC8bLMlYWSQZ9dugN6gXwoVaVdpmUxDc6
	JvDCYg+Z4XUTglWprTQzjOSw==
X-Received: by 2002:a05:600c:3e11:b0:487:22ad:403e with SMTP id 5b1f17b1804b1-4872911ca63mr43876055e9.14.1774629226373;
        Fri, 27 Mar 2026 09:33:46 -0700 (PDT)
Received: from localhost ([212.133.41.47])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48725eb52e5sm21200085e9.7.2026.03.27.09.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 09:33:45 -0700 (PDT)
Date: Fri, 27 Mar 2026 17:33:42 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Hiago De Franco <hfranco@baylibre.com>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	Yoann Congal <yoann.congal@smile.fr>, yocto-patches@lists.yoctoproject.org, 
	Yi Zhao <yi.zhao@windriver.com>
Subject: Re: [yocto-patches] [meta-selinux][PATCH] Enable SELinux support in
 native packages
Message-ID: <acau25bGKj2NcLiw@monoceros>
References: <baff51f1-f0d9-4ae3-ba7f-bcbf1c0272c3@windriver.com>
 <14ad3c9da707249caf3f5157cf9be0b936ebfe5e.camel@linuxfoundation.org>
 <pfqfrlcduuigcvfdvn5ljjmjomee2wwn7xxu5ikibinoz57udn@dusca2fnhwja>
 <DH59MQQ8LHWC.25HPETRJUAGLI@smile.fr>
 <abpXXjX8C23hL8RO@monoceros>
 <e5bcfc29f4ab15e0ac21e2273a679821373530c6.camel@linuxfoundation.org>
 <abqEzAjosilonVNP@monoceros>
 <d8f70ee878b8101ef7a5f1b11c1bb52aa172c89b.camel@linuxfoundation.org>
 <abqvgTxKOJxWCxAB@monoceros>
 <s3dvnilzp3mv6xstf7syd42ru3pgjaiebooacljibgf5zpe4ba@ezu4xnouvw26>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5bmriwryovh3zdgn"
Content-Disposition: inline
In-Reply-To: <s3dvnilzp3mv6xstf7syd42ru3pgjaiebooacljibgf5zpe4ba@ezu4xnouvw26>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 27 Mar 2026 16:33:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3568


--5bmriwryovh3zdgn
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [yocto-patches] [meta-selinux][PATCH] Enable SELinux support in
 native packages
MIME-Version: 1.0

Hello Hiago,

On Wed, Mar 25, 2026 at 09:28:19AM -0300, Hiago De Franco wrote:
> I would like to add something to the discussion that I just found
> yesterday.
>=20
> By enabling the native patckages to have SELinux by default, GPG=20
> breaks if secureboot is also being used. See the error below:
>=20
> ERROR: linux-yocto-6.6.129+git-r0 do_sign: Failed to import gpg key
> (user-keys/boot_keys/BOOT-GPG-PRIVKEY-BOOT-SecureCore): gpg: importing
> secret keys not allowed
> gpg: Total number processed: 1
> gpg:=A0=A0=A0=A0=A0=A0 secret keys read: 1
>=20
> This happens becaus of [0]. I had to specifically disable SELinux for
> the GPG native package.

This is ridiculous. What about

diff --git a/g10/import.c b/g10/import.c
index ba62d2322c93..44b113d77222 100644
--- a/g10/import.c
+++ b/g10/import.c
@@ -3235,21 +3235,21 @@ import_secret_one (ctrl_t ctrl, kbnode_t keyblock,
      cipher algorithm (only checks the primary key, though).  */
   if (ski->algo > 110)
     {
       if (!for_migration)
         log_error (_("key %s: secret key with invalid cipher %d"
                      " - skipped\n"), keystr_from_pk (pk), ski->algo);
       release_kbnode (keyblock);
       return 0;
     }
=20
-#ifdef ENABLE_SELINUX_HACKS
+#ifdef I_WANT_A_BROKEN_GNUPG
   if (1)
     {
       /* We don't allow importing secret keys because that may be used
          to put a secret key into the keyring and the user might later
          be tricked into signing stuff with that key.  */
       log_error (_("importing secret keys not allowed\n"));
       release_kbnode (keyblock);
       return 0;
     }
 #endif

instead? Or does someone understand why it's considered easier to trick
the user into bad stuff with SELINUX enabled?

> So, in this case, if we would to like to proceed with this patch, v2
> would be a better option to prevent such errors.

Well, it only prevents the error if the yocto build doesn't have

	DISTRO_FEATURES_FILTER_NATIVE:append =3D " selinux"

in local.conf which is recommended in the docs with v2. So I (still)
don't consider v2 better.

Best regards
Uwe

--5bmriwryovh3zdgn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmnGsWMACgkQj4D7WH0S
/k4nzAf9HREV9apDLDuffeexzrrrY/JBgkC7trDsstFYGrebHkVD7YrSE3a9bhW5
cGVMHballZmlDheCgMGuPhDIShJEICcV8cL3tyikQaX4Y76rTl8kEoisrywZSHla
bb6hkXDM//2sZhsDFx0w8kuGxe1UwoV9c1Dca/TcWhoxw6+vDOivo7C4jFDLqQs+
Oxt2RVctqHtjogwBpRgHzTPre/9xXdQoKaF8wH8XdeasqO5jutmSQEfybabxL10E
YSsLoGGXXQmpv9h8cZoZglMQsR+J1H66ZoGNqaVMl1rjf/rOtDDJhX0moeAIccb0
Jo4S0ff5bkBSw7WkrTarDgGLUdLXHg==
=ldTT
-----END PGP SIGNATURE-----

--5bmriwryovh3zdgn--

