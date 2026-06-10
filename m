Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983DACD98C7
	for <webhook@archiver.kernel.org>; Wed, 10 Jun 2026 18:37:54 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.27906.1781116669625910515
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 10 Jun 2026 11:37:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Ire6hqmt;
 spf=pass (domain: konsulko.com, ip: 209.85.128.182, mailfrom: tim.orling@konsulko.com)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7dfe7712572so66132847b3.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 10 Jun 2026 11:37:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781116669; cv=none;
        d=google.com; s=arc-20240605;
        b=IKeUVYWQP+VKJPYsX0O1PTlTRhItjlOPcZ3nYKCvdb0Lg3xdf00hVVkGcNY+iv5spd
         oTKp3aIWFW7HWa7kB/tdIB8JI3ZdKGWupRpV9TlLtag8xjkWR6bThV7XwZV3IFciSCj3
         ijnyksUnATbcuLeSWuRuKTu885NJRxb1lDifcFCQlNph85CmtwKrLiXVsmr9m0Vv5i1e
         IgP1OfN2fuAwm8FMnYpCIQe8GktQS24yH6ha1EEB7yWoYguTcXgaMgZCTtSfx2yYTh2p
         t92jjoPLZh64QGOjYvWCuL6geHXJFugqqjx6woNqoGg8RyLP7BEC2n8aH+2Citfjzx2g
         XRIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=sObFjNqA9XfjmGJXZAqHsKmRNDewyJ/5l097PXL544A=;
        fh=oelZnrg5dmur//Cq9EZ6v+RhAeHGCj2nFzzrUJxuFwI=;
        b=Q4HuSwwA7Guae7a5AjiEXRFh+woBU1BHDMTFB4LwkCM4d+rvQjxpJWu9JpHDxdYfjv
         +XkD1fRG+HMqm2whVR1EPiZnBfhIrDHuYvFiBXKHU5L9uNG32n8aBX9qWthtT+idEksh
         N9YjSkNTaahTYqMzC0/OP2xfjFPQoAIxnf4I5+S4CDvIW5u+ub/JfVklWHTRd2vQDJWR
         u5eWmj4VzYOE1mOjgCEDPvc0NO0MsU5vABJ1tQDoO24NK2jyneymVujh0WiOXAiAuBJ4
         MX8lmYg6m0W48jQBP9w/F94tjfaN4WXMNNLk/9MgAclcmvqxL7t2G11tzIu4ZIwI6vIt
         PJYw==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1781116669; x=1781721469; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sObFjNqA9XfjmGJXZAqHsKmRNDewyJ/5l097PXL544A=;
        b=Ire6hqmtzD+wieDs116GHHfc7CLXfBkJuyZRrvXFNr0CmpXkpm2uPmL9ezdF2kP0ly
         RUBJrDBE4YKnHo3axEznAdb0ZJeSsEgkznd0Ak40p4GsSmCQyGk1LkGGvmCp2wYL2NDG
         T/Ju3R5AHphGOEov8HbxIqZxqqJKhQl8ghbEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781116669; x=1781721469;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sObFjNqA9XfjmGJXZAqHsKmRNDewyJ/5l097PXL544A=;
        b=W60D5/AmSs3bjCyFkuK1b5MuFcFgfXa31ymgxsAhdxTK13bR2orhSfc46OAlxPQ/V/
         X9ZkQcDSaHk8u/Nw8pun4QCw6JO5e00JnVND4zu3ANshWP+Ompil3k5WckSSnXbIgtp5
         pYQX18VO8B0lEFJKWAIIvHkExxFnKO3hkzfBW7dteZvhukejcCv2oYiBLfAEMLyKTd8E
         lzeliCJyIWw/DeqAYps41nbKAgxdS05U0SEGYlmSNNHWI6B1wQlvalyEAS0evJ3B76PF
         ZIZNjCS62wCgDxazDYRN6uz1sFw7DyHiRoZKhEOwDIbkJBMhBQm7J3rh7h8mjMHo7AmJ
         jgaQ==
X-Gm-Message-State: AOJu0YzB1GNBR1tLDZ+7S/o6fGBPR2406t2xTMFv7/6NmoInJ0WlMOwK
	9venLXwz9+S0kMLRiXcTKPpUPtlE+Ua0yRBA2ybzPDp22fWda0CtpK9/lZTb/zcp5j2iqL791Jr
	A/NQoQMiYzah6I11N4TZDhYSi9O5iZRXXDhXgNZQKoQ==
X-Gm-Gg: Acq92OHjeej5EUZERedjqxVOC+xGsCb7sBrz5wbXVff0WTuhHQ/1jt2tUUBXPH3U+JN
	pDcZQHyP8Uimfq0bbHMPEX2b4PJRdfP+mwkzkfPuM6sxSE9s4f7tmPmLp+MJa1ojwTVlFxXiEFy
	p6rARZI1TPDnVGxd7r1AuIPHwY3uVFi4/RLGztL17vs+uUaSACIQ61c6/B9YZ2tPOWvG8N9wDk+
	CrM/LfZWoWWgwDi/jT7DPQM2aV7t3102qh68Wt8DgxiqK/1WtSzKQ0YQynySePWm+PHKVXy4Qzw
	d3V6vJ/8aZSJ+tl/Nw==
X-Received: by 2002:a05:690c:4907:b0:7cf:d242:d94a with SMTP id
 00721157ae682-7ed0d1d9d24mr244663787b3.25.1781116668583; Wed, 10 Jun 2026
 11:37:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260609164032.1415124-1-sandeep.gundlupet-raju@amd.com> <20260609164032.1415124-3-sandeep.gundlupet-raju@amd.com>
In-Reply-To: <20260609164032.1415124-3-sandeep.gundlupet-raju@amd.com>
From: Tim Orling <tim.orling@konsulko.com>
Date: Wed, 10 Jun 2026 11:37:37 -0700
X-Gm-Features: AVVi8CdC35WcNiMeYne8sP4SxiiAn6xV18GcQXXulgJ2RNljenz6a03vBHkZIzI
Message-ID: <CAOyo-84YrMoXjH7O6UExaby+Jx6h9ZK7Fnvg2xL_Td_iw-0i2A@mail.gmail.com>
Subject: Re: [yocto-patches] [layerindex-web][PATCH v3 2/4]
 connectivity_check.sh: Use yoctoproject.org for HTTPS check
To: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
Cc: yocto-patches@lists.yoctoproject.org, mark.hatle@kernel.crashing.org, 
	piotr@qbee.io
Content-Type: multipart/alternative; boundary="00000000000055adc20653ea8ac4"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 10 Jun 2026 18:37:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4201

--00000000000055adc20653ea8ac4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 9:40=E2=80=AFAM Sandeep Gundlupet Raju <
sandeep.gundlupet-raju@amd.com> wrote:

> Replace google.com with yoctoproject.org as the HTTPS test URL.
> google.com may be blocked or considered unsafe on some Linux host
> environments, while yoctoproject.org is a more appropriate and
> reliable choice for a Yocto/OE layer index deployment.
>
> AI-Generated: GitHub Copilot (Claude Sonnet 4.6)
>
> Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
> ---
>  docker/connectivity_check.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/docker/connectivity_check.sh b/docker/connectivity_check.sh
> index 2e46ce4..630d0dc 100755
> --- a/docker/connectivity_check.sh
> +++ b/docker/connectivity_check.sh
> @@ -18,7 +18,7 @@ if ! wget -q $HTTP_TEST_URL ; then
>      exit 1
>  fi
>
> -HTTPS_TEST_URL=3D"https://google.com"
> +HTTPS_TEST_URL=3D"https://yoctoproject.org"
>

The yoctoproject.org site downloads a lot, but we have an existing
connectivity check URL.

openembedded-core/meta/conf/distro/include/default-distrovars.inc:CONNECTIV=
ITY_CHECK_URIS
?=3D "https://www.yoctoproject.org/connectivity.html"

I will just make the edit before pushing the commit.

 if ! wget -q $HTTPS_TEST_URL ; then
>      echo "ERROR: failed to fetch $HTTPS_TEST_URL"
>      cleanup_tmp
> --
> 2.43.0
>
>

--00000000000055adc20653ea8ac4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jun 9, =
2026 at 9:40=E2=80=AFAM Sandeep Gundlupet Raju &lt;<a href=3D"mailto:sandee=
p.gundlupet-raju@amd.com">sandeep.gundlupet-raju@amd.com</a>&gt; wrote:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">Replace <a href=3D"=
http://google.com" rel=3D"noreferrer" target=3D"_blank">google.com</a> with=
 <a href=3D"http://yoctoproject.org" rel=3D"noreferrer" target=3D"_blank">y=
octoproject.org</a> as the HTTPS test URL.<br>
<a href=3D"http://google.com" rel=3D"noreferrer" target=3D"_blank">google.c=
om</a> may be blocked or considered unsafe on some Linux host<br>
environments, while <a href=3D"http://yoctoproject.org" rel=3D"noreferrer" =
target=3D"_blank">yoctoproject.org</a> is a more appropriate and<br>
reliable choice for a Yocto/OE layer index deployment.<br>
<br>
AI-Generated: GitHub Copilot (Claude Sonnet 4.6)<br>
<br>
Signed-off-by: Sandeep Gundlupet Raju &lt;<a href=3D"mailto:sandeep.gundlup=
et-raju@amd.com" target=3D"_blank">sandeep.gundlupet-raju@amd.com</a>&gt;<b=
r>
---<br>
=C2=A0docker/connectivity_check.sh | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/docker/connectivity_check.sh b/docker/connectivity_check.sh<br=
>
index 2e46ce4..630d0dc 100755<br>
--- a/docker/connectivity_check.sh<br>
+++ b/docker/connectivity_check.sh<br>
@@ -18,7 +18,7 @@ if ! wget -q $HTTP_TEST_URL ; then<br>
=C2=A0 =C2=A0 =C2=A0exit 1<br>
=C2=A0fi<br>
<br>
-HTTPS_TEST_URL=3D&quot;<a href=3D"https://google.com" rel=3D"noreferrer" t=
arget=3D"_blank">https://google.com</a>&quot;<br>
+HTTPS_TEST_URL=3D&quot;<a href=3D"https://yoctoproject.org" rel=3D"norefer=
rer" target=3D"_blank">https://yoctoproject.org</a>&quot;<br></blockquote><=
div><br></div><div>The <a href=3D"http://yoctoproject.org">yoctoproject.org=
</a> site downloads a lot, but we have an existing connectivity check URL.<=
/div><div><br></div><div>openembedded-core/meta/conf/distro/include/default=
-distrovars.inc:CONNECTIVITY_CHECK_URIS ?=3D &quot;<a href=3D"https://www.y=
octoproject.org/connectivity.html">https://www.yoctoproject.org/connectivit=
y.html</a>&quot;<br></div><div>=C2=A0</div><div>I will just make the edit b=
efore pushing the commit.</div><div><br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
=C2=A0if ! wget -q $HTTPS_TEST_URL ; then<br>
=C2=A0 =C2=A0 =C2=A0echo &quot;ERROR: failed to fetch $HTTPS_TEST_URL&quot;=
<br>
=C2=A0 =C2=A0 =C2=A0cleanup_tmp<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div></div>

--00000000000055adc20653ea8ac4--

