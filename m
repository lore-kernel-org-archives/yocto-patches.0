Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.39309.1793007271749734899
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 26 Oct 2026 02:34:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=RYuhDobE;
 spf=pass (domain: gmail.com, ip: 209.85.219.49, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-91ba702cceaso33170716d6.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 26 Oct 2026 02:34:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793007271; cv=none;
        d=google.com; s=arc-20260327;
        b=o9LUOt2M41FUAozIlzmHAFYRSRD5z96gP/HIt+ACd7C0CLi4pho568xl4FlAkRfbHp
         y66PsItScPGLD3b23oLDaHVsl5xp+4OhNQlTbsSzmmAvpTj8Y22+7Y6f2GMU2B1Sprbt
         GRfsu2iP1p7Is+eU7FxBbfav4hO++AWD0Wf4aX5x0ZfxvNHIYnkZcNR0FqokqKe1tLsU
         o8sGh1+IGQNiTYJRYP1PDQJzxcqy9h52i0g0Y+aYW7thsAqTOFSEvCHBhcbIPiU9TTHn
         KiiPjhrw1xqCTCPAyvzcHrwbm1AibBCWO8JZXf2T5UY5UPPLKoYIo+ox1vRUuvVUZw+m
         zskw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HGb0WGpc4aRXvJaPTqhjAentpZo664HxAasEpzGZ+ug=;
        fh=28JQhdK5h5mLF5DLv2fLR8YFHEF0yTvH5opUNnJ6Zzo=;
        b=bbqJHY1qGfAlf+7sDIATWgCLB2WZ83zM6/Fs8lrNLduNGsVfLKPr3g/RCnkJQ4FT22
         ZMGKQrhn1rASR8b4Ye2k8+cFE9Fh9cRsyF6NyQsi9AbkkUZ9Fs5aqin+7srUjYVbaaSc
         rSAJVfwh/5/Pwpb8gaf+QF3uXxd28UHlCj0Fu2/XKfOyamYK2vSkgUkgskai8PHMX6OY
         uGVYivWUgecffPitjJJvWcJdRoxSJHilBJLkpURieNrNrofwyg5KYUltTsf5pMjHLDQf
         xti5soOACwp1/YdJc237WSEngpgUSsVKoagjKwk/3NbD6jBXlbILw3aqEUMqIE8BT8lV
         kr4A==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793007271; x=1793612071; darn=lists.yoctoproject.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HGb0WGpc4aRXvJaPTqhjAentpZo664HxAasEpzGZ+ug=;
        b=RYuhDobEsoxjqKJioWkz8H7+rt66I02pIV+bA0+7Bm4451jRB7yFIZkFdsdkKK2V6K
         amHuwC2olt1EQnUzdU66loEH/3SKkVUS278gVCgzo64D3zsrEiWHKDAE9FIDmvvWxEI5
         BnkGRV3GYx7eIF1Z6XUC/5Jrbqqp797Nwg+FDY8OX6xZ3K5veFd2RjorJitTGza5a9rx
         RpfKAhzecEZ8IDSM3Fs70Jz1kkqFGGTMpyuru4gqkZFZt+zAgqJndEljADnk72tRol8o
         d4pQ6iO872jmlPfosEa1wC2KmbvR9s1Qo5nhfpD5DrJu9KACqFrdRZQBQvhivrbl4HVV
         nq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793007271; x=1793612071;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HGb0WGpc4aRXvJaPTqhjAentpZo664HxAasEpzGZ+ug=;
        b=BJBX/TkpS1yHExsNtbBAAqtbB0Vt5q0s1R0rSyjFZs6epQW7o5DaJPSRpGefPcH/vx
         tXgA3+8K4fQvLFB4B3h7vGFUatXUSyWw2xhYWcCPGsBkdc9ahg3Mf53WUbyoi29UCaJC
         DHFZ9QMDJ+P4PbR6sfQmY+7SpGTrXqnQxBvRjwQg+iwA7TcPamb7LIz+zPcMymJ913XG
         VkXzbMZxaF9EHyJs01mORFWmsGXZ+ER1Rr36eGx8z+CV6wRXZ5SoFFO/vp/PyMb+zLoa
         WYpTDLwoY/hPDKqA6fFMRnbLIFS6NW1ZHRSbIcl+kXAe2WhzOEXVHbvznDI+rLqMDMmz
         waEA==
X-Gm-Message-State: AFq9FYIBxKYU+rh1pTX9bEb3ZyWtUJQeXBz1m3zFDj1uE5IzJBbQMLQR
	y6a+4u85gY3TJm6A0/xKn2SanSZi8V97G9+inij98vgVEflAeKDEKZOerePJJJMaf2E6Xz5VZcU
	WSJUTjXWnS3L1MyMx03nAFmVUqYgkneE=
X-Gm-Gg: AYBFou1mfXLQoryDvt8ONaq6iRAohJ85nHZNboZm7+nhg8lCUmsYk5tzSe9IrZxJmcT
	I8ZP0rjdZTI2kc51C88O/NYvg74WlnFq7MVjrCr/b8PQWRHUELTk83OgwQ4EWJtH3poZ/49Aw8L
	uvzy6ZVcntTLk6iO5S/xISDneGHZQgo1yrG6c2xDob4i4xtY1Dc5kCQa7wEnGtGdpqzEiVbe2gm
	y6kcl9JGt5x0s4cMn/KR8l4Cpw7RWAhZz9j01GGitTd1QdRzwSCTynCPBqR+nHmZrpb552ZRu1N
	K0UUgA0nPpUsCHjjmbhyPT+IllVDNFXFfNbWCpm5DCBx5wK1oE3ChjFFGQzVjjLPn2VVofnWuzw
	Ym6wpKcQWjx/Ew4HICKB/0Hj8SNRRI0R/saO6vfda12FUUL+ih2RH7dJcbRbywP6ksP6zrR0=
X-Received: by 2002:a05:6214:21e4:b0:91b:81d5:f8f6 with SMTP id
 6a1803df08f44-91c48df593emr102434386d6.10.1793007270608; Mon, 26 Oct 2026
 02:34:30 -0700 (PDT)
MIME-Version: 1.0
References: <20261022144540.1691265-1-daniel.turull@ericsson.com>
In-Reply-To: <20261022144540.1691265-1-daniel.turull@ericsson.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 26 Oct 2026 10:34:18 +0100
X-Gm-Features: AclHuK_UfXRRzInXBEsKvX02oGSyQ5jMLDLmV0R9-J3_gLwwngZ_4fiwHtkjRxQ
Message-ID: <CANNYZj8vHVkC09iiFmH_o_f1WPdgA3EUs8cPp17vpZnJpUG1=w@mail.gmail.com>
Subject: Re: [AUH][PATCH v2] steps: skip changelog in commit message when
 devtool flags it
To: daniel.turull@ericsson.com
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="00000000000071c341065ebb0934"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 26 Oct 2026 09:34:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5155

--00000000000071c341065ebb0934
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Oct 2026 at 16:46, <daniel.turull@ericsson.com> wrote:

>
> +def _changelog_skip(pn):
> +    """Return True if devtool flagged the changelog of pn as badly formed
> +    for a commit message (RECIPE_UPGRADE_CHANGELOG_SKIP in oe-core)."""
> +    metadata_path = os.path.join(os.environ.get('BUILDDIR', ''),
> +                                 'workspace', 'changelogs',
> '{}.json'.format(pn))
> +    try:
> +        with open(metadata_path, 'r', encoding='utf-8') as f:
> +            return bool(json.load(f).get('changelog_skip', False))
> +    except (OSError, ValueError):
> +        return False
>

The json laoding/parsing should be probably refactored so it's done only
once, and set as a property of pkg_ctx?

Alex

--00000000000071c341065ebb0934
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">On Thu, 22 Oct 2026 at 16:46, &lt;<a href=3D"=
mailto:daniel.turull@ericsson.com">daniel.turull@ericsson.com</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
+def _changelog_skip(pn):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Return True if devtool flagged the changel=
og of pn as badly formed<br>
+=C2=A0 =C2=A0 for a commit message (RECIPE_UPGRADE_CHANGELOG_SKIP in oe-co=
re).&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 metadata_path =3D os.path.join(os.environ.get(&#39;BUILDDIR&=
#39;, &#39;&#39;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;workspace&#39;, &#39;chan=
gelogs&#39;, &#39;{}.json&#39;.format(pn))<br>
+=C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with open(metadata_path, &#39;r&#39;, encoding=
=3D&#39;utf-8&#39;) as f:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return bool(json.load(f).get(&#3=
9;changelog_skip&#39;, False))<br>
+=C2=A0 =C2=A0 except (OSError, ValueError):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return False<br>
</blockquote><div><br></div><div>The json laoding/parsing should be probabl=
y refactored so it&#39;s done only once, and set as a property of pkg_ctx?<=
/div><div><br></div><div>Alex</div><br></div></div>

--00000000000071c341065ebb0934--
