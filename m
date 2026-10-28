Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.38996.1793180068262654399
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 Oct 2026 02:34:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=aNqMs/QT;
 spf=pass (domain: gmail.com, ip: 209.85.219.43, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-91befe703c4so7502596d6.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 28 Oct 2026 02:34:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793180067; cv=none;
        d=google.com; s=arc-20260327;
        b=roKPINSVX8e2386208q5MDXH8DhrpMhdNDPMj0svJ4O35/Rqc9qTUmHIRXcol5lZNo
         TvfItyMC56VMtBrtcVq92eUYYwzZr2jQm6n7UBrYtoLuhUo2xRjwh4gAIYnLmBLdfPQQ
         joTSDmMTMSy7oiTmp6XVSgdhaq3AYinvbo0StS7WN3Ki8ZaT5uk4fQ3hGtpnQb6626or
         fTlzz2FPDFFYR19GDX2Ngj0RdqMPYkawG9KbfoqLf49ZBvSQJ0PNL7hXbnMEyQQg6gEz
         BM7cWuqYiwW+zYxI5k5N1ORPngLtCM4h9IpqT5Uv83TIZx8gtMhM4StD5uFJikxD5YOO
         NeUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=KwJynstliynkYfIt/4Lt9dEWRMIMf7HH5t0YgvVkTPo=;
        fh=28JQhdK5h5mLF5DLv2fLR8YFHEF0yTvH5opUNnJ6Zzo=;
        b=EsfnhoSLlXJfzr6c8hRBm6g081/iGM1rB/5n+HOH8Nj9aUhoskJp3K5Sd6So1gOFQH
         b4OIx0mRCNXbX2AgJ6j3tgepFE1smsdOU4Jm3r4WYg2M51c1y6bsGwibUWg47zZU8bQk
         GLRrK2LZOkf3c3RKkrQF/oyC2YKfKiJgzW7YbmiJhrybqdDOcJhwsmWnVeLOU5V/Dr1O
         /slms6X7O7S0V3zS2Q9zkmL1BU3vpqsMZ3lJd+l/XXPB4yruvlTRnxbYAP3BJyUgNfdx
         Rfwkx08jEBRUbhdmODvmXxcKQuQL3vyihqCP9vlGo7qdbEwG3/FE3QtRo5GhFyxyooln
         Jcjg==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793180067; x=1793784867; darn=lists.yoctoproject.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KwJynstliynkYfIt/4Lt9dEWRMIMf7HH5t0YgvVkTPo=;
        b=aNqMs/QTy4kxu2hMKaOP/2vaPgVRMXDUny6FlZQzln8flwD3FBpuCME6LNXD1qRxJK
         aRJ73awn6k/StbO+oY87tJglE7KGaBvzuKErlh8eIZXEbNl9ht5ZxhQ25t8buTMXltCa
         dXpDqT1d1YQzedMPfqgB5WBq+ps85dvWScznrUWNEw2pfIFb+It0pi0hLYw4fMzZig6B
         GUnTAqQXmpSFA1Z2UyOFU302oXW4FCfgl1JGicRuCfxATwSjypezM4HuzGxCgr9sA2Ac
         LM42+f04jrIAv1cev3ydhzZIPYofX4UEO0g2XEWkJDNYvQMCsUtRyV6zRjWBxDl4kbvI
         xS6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793180067; x=1793784867;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KwJynstliynkYfIt/4Lt9dEWRMIMf7HH5t0YgvVkTPo=;
        b=t9bGg54LK4gecbkP0FPSR2a6gfaJhyu2kjCm98mVHmjgltPqzU7CJyDLAH93d2NId0
         XkQVGGIxjTsu4MMgauFuAF8FIRE3PHhTBNzPfYCRyjkx2Eak5dS6mtbzvojMFSGuUwFH
         qXdeQgV8RKJlxxhcgLTRlRX6omEHwhD6o4Gw5Rk6mTfV/EVVLGQKWumvwjZAwGGkBOsR
         NPwheSuRa4A+x2KPZSGYnzE8sHVyO+aDGActhT7fivtCoHV8wYbOks5gPFhZO+Tar7XK
         n9EaU+yXQAWHL/S8w06IKkHwHb0FBDd8ahFkLnbugNdqCkkmP9G9vyi9L5+siTJ4IrYv
         4n8Q==
X-Gm-Message-State: AFq9FYIZIHsFeZ5XpJpodvFTx2drrtR/gHWR9r9MkXA1BPRp4Q/0DFGN
	RliogJvyMk6M53kEeqT2ejwDHh3Ayd7FX2QkKxMGNT+OUYANDD6eHe658xc2EzukUZNOCc1OB0B
	f17eJXk6RZXPgNl9lxNEoGs3njMfOBGI=
X-Gm-Gg: AYBFou1GRCNrnKdu8/4hzLdo0DhWzriNvKLycWhVxkTYS9b3IdViNHhjb9HCPUGbMyd
	RS1JLqRCfGv9CkBIpxzU7c5sogZxBiBQgobtVwv+YGqeeLbObGCNFIfkSFbCQ3cTsE4xExYa2dS
	Ff8OznHeG4rgM1M+S4g1s0H6jvjy7L96+jnPN26JlN9IKs6npmC3uxRfdReN/oSOPo/NY/IW5zd
	zjwrEfqQl0IEe/JaeT4fsef8A62cDZJD5wEoPqxbd6jnfFAzLoWtoOBGHWQV8bJPA2KyNVnk9Gj
	/CSTyHluXyLXuJK5SKmAabAognyF0F3Sk6EOBrxLEjnSNpdOZd3ML2dauwRWH6UqiLF4+5qnZ6m
	N+qz7qLEI2Ax+jwn4+lvpi6PAH9NB7vLmaoM/Yi4K2E1RlNhcQl1yIZiWznjxN7ZeDukuQDc=
X-Received: by 2002:a05:6214:f2b:b0:91b:8457:7930 with SMTP id
 6a1803df08f44-91c7cf4c91bmr26274346d6.19.1793180067134; Wed, 28 Oct 2026
 02:34:27 -0700 (PDT)
MIME-Version: 1.0
References: <20261027133046.300849-1-daniel.turull@ericsson.com>
In-Reply-To: <20261027133046.300849-1-daniel.turull@ericsson.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 28 Oct 2026 10:34:15 +0100
X-Gm-Features: AclHuK_L0zrssn8TMdFC29gF9GvGepReEpd3BZ3HP-uOjaWt08EeBaUSD587n_M
Message-ID: <CANNYZj9rdRkWHnR7VV48_GBJOEfXnwivZoVXvhF=finTXzVn=w@mail.gmail.com>
Subject: Re: [AUH][PATCH v4 1/2] steps: read changelog through devtool's
 metadata file
To: daniel.turull@ericsson.com
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="000000000000eb8205065ee34473"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 28 Oct 2026 09:34:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5168

--000000000000eb8205065ee34473
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Oct 2026 at 14:31, <daniel.turull@ericsson.com> wrote:

> +def _get_changelog(pkg_ctx, workdir):
> +    """Load the changelog and its metadata written by devtool upgrade into
> +    pkg_ctx and copy the changelog to workdir."""
> +    pn = pkg_ctx['PN']
> +    changelog_dir = os.path.join(os.environ.get('BUILDDIR', ''),
> +                                 'workspace', 'changelogs')
> +    metadata_path = os.path.join(changelog_dir, '{}.json'.format(pn))
> +    try:
> +        with open(metadata_path, 'r', encoding='utf-8') as f:
> +            metadata = json.load(f)
> +    except (OSError, ValueError):
> +        # devtool writes no metadata when there is no changelog
> +        return
> +    for key, value in metadata.items():
> +        pkg_ctx['devtool_' + key] = value
> +    changelog_path = os.path.join(changelog_dir,
> metadata['changelog_file'])
> +    try:
> +        with open(changelog_path, 'r', encoding='utf-8',
> errors='replace') as f:
> +            text = f.read()
> +        shutil.copy2(changelog_path, os.path.join(workdir,
> '{}-changelog.txt'.format(pn)))
> +    except OSError as e:
> +        W('Failed to copy changelog for {}: {}'.format(pn, e))
> +        return
> +    if text:
> +        pkg_ctx['changelog_text'] = text


This is closer to what I had in mind, but still not quite there. Claude's
code output isn't particularly good here, at this point I would just write
it by hand if I were you.

1. Don't suppress absent files or filesystem issues in exceptions. Json
file should always be there (this probably requires a tweak to devtool), so
that there's a track of what happened with changelog extraction. Similarly,
if anything in the secont try..except block failed, then it should be a
hard error.

2. Have a function that returns the json content, and call it thus:

pkg_ctx['devtool_upgrade_metadata'] = _get_devtool_json(...)

And then when needed:

changelog_text = _get_changelog_text(pkg_ctx['devtool_upgrade_metadata'])

Alex

--000000000000eb8205065ee34473
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">On Tue, 27 Oct 2026 at 14:31, &lt;<a href=3D"=
mailto:daniel.turull@ericsson.com">daniel.turull@ericsson.com</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">+def _get_chan=
gelog(pkg_ctx, workdir):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Load the changelog and its metadata writte=
n by devtool upgrade into<br>
+=C2=A0 =C2=A0 pkg_ctx and copy the changelog to workdir.&quot;&quot;&quot;=
<br>
+=C2=A0 =C2=A0 pn =3D pkg_ctx[&#39;PN&#39;]<br>
+=C2=A0 =C2=A0 changelog_dir =3D os.path.join(os.environ.get(&#39;BUILDDIR&=
#39;, &#39;&#39;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;workspace&#39;, &#39;chan=
gelogs&#39;)<br>
+=C2=A0 =C2=A0 metadata_path =3D os.path.join(changelog_dir, &#39;{}.json&#=
39;.format(pn))<br>
+=C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with open(metadata_path, &#39;r&#39;, encoding=
=3D&#39;utf-8&#39;) as f:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 metadata =3D json.load(f)<br>
+=C2=A0 =C2=A0 except (OSError, ValueError):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # devtool writes no metadata when there is no =
changelog<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
+=C2=A0 =C2=A0 for key, value in metadata.items():<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pkg_ctx[&#39;devtool_&#39; + key] =3D value<br=
>
+=C2=A0 =C2=A0 changelog_path =3D os.path.join(changelog_dir, metadata[&#39=
;changelog_file&#39;])<br>
+=C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with open(changelog_path, &#39;r&#39;, encodin=
g=3D&#39;utf-8&#39;, errors=3D&#39;replace&#39;) as f:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 text =3D f.read()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 shutil.copy2(changelog_path, os.path.join(work=
dir, &#39;{}-changelog.txt&#39;.format(pn)))<br>
+=C2=A0 =C2=A0 except OSError as e:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 W(&#39;Failed to copy changelog for {}: {}&#39=
;.format(pn, e))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
+=C2=A0 =C2=A0 if text:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pkg_ctx[&#39;changelog_text&#39;] =3D text</bl=
ockquote><div><br></div><div>This is closer to what I had in mind, but stil=
l not quite there. Claude&#39;s code output isn&#39;t particularly good her=
e, at this point I would just write it by hand if I were you.</div><div><br=
></div><div>1. Don&#39;t suppress absent files or filesystem issues in exce=
ptions. Json file should always be there (this probably requires a tweak to=
 devtool), so that there&#39;s a track of what happened with changelog extr=
action. Similarly, if anything in the secont try..except block failed, then=
 it should be a hard error.</div><div><br></div><div>2. Have a function tha=
t returns the json content, and call it thus:</div><div><br></div><div>pkg_=
ctx[&#39;devtool_upgrade_metadata&#39;] =3D _get_devtool_json(...)</div><di=
v><br></div><div>And then when needed:</div><div><br></div><div>changelog_t=
ext =3D _get_changelog_text(pkg_ctx[&#39;devtool_upgrade_metadata&#39;])</d=
iv><div><br></div><div>Alex</div></div></div>

--000000000000eb8205065ee34473--
