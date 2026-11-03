Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9854.1793708084484972645
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 03 Nov 2026 04:14:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=jBnnH7qc;
 spf=pass (domain: gmail.com, ip: 209.85.128.178, mailfrom: alex.kanavin@gmail.com)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8b06c0794cfso37217047b3.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 03 Nov 2026 04:14:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793708083; cv=none;
        d=google.com; s=arc-20260327;
        b=p8w2W+IZOiTYE5I5BHRgcBZ6nLs7zUUCtF2aI6rI9nyNOwhSZba9FdkShpRBxLhP7I
         GnIe6QCDI0rvFpFl2j1W62fK0bxtcAi9+/3iPEDVIFEyCspqRT2SsxxfMZGfTWXVbRdr
         0seOcaF/E4A5wbarXarhq+oIx4q7uepDdcW9ANX+KzJx12va+hPI56/o0FCmBEFnAFr7
         +Ue2TGftzVcIUc001/Bd846efOPWlra9pekEs7HH3NFUlTyD/BMnrnHl8zAL2NyRhXXL
         MgZnN7X77l89w6+OIv3znfrSXh5QOjf8IIOMbOdF63zNcZTaVqXlZnAlFr4NUrfUuY3J
         e37A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Pf9+dqarDik/1VFNyF4qDgyRQaekTFSfrgk/fsHvIPE=;
        fh=rW+F4vWbYRrKKqRcQBOl75fisa8SOH06jh5yjpycWq0=;
        b=nUgcGE/Os2JFRw5Lac2arUZqngL+rgvOAVlHzi8iXUGO/STBa+a5joJapXlOPIAvRF
         M0KJP8mc1vO/26UiMOHMXfGmMwbTkh+H8+P2XV2U/iEpwnS+5Rc5IpnOUXFfBmf9oxN0
         LY6HDnN+3zTE4TgEjbHv/5rC5nQdAtOH5mDud8Z9K2yn5NTwwyhTtq9Ui84/ATIm6jUP
         MvzelrOk1BtOmxTW8XOxF+CRQWgtpn0+1b4/A+ZuKwkTVSInyonXrpa2+NGATAgPQWrz
         cFg2uf0n/u8Qpv7qVLq7V/+8JCABYOiOqGxG4vsKHtADjiVF7WaBeqDeST3OwOgpHJNr
         PG0A==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793708083; x=1794312883; darn=lists.yoctoproject.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pf9+dqarDik/1VFNyF4qDgyRQaekTFSfrgk/fsHvIPE=;
        b=jBnnH7qcV5oV8eSLix2PhiuQ+2QEVJB2w4VS3aChqWtjiM8CiA2tKfEw4QwA+Ox1p0
         CFCO6UUbEzdNh+WtgBqfrDpVpr8SLNwZkYVgeOtW1hqHAO4ivLI76iASabjHa+O0uMLt
         YL6mwb2xJvf10Eyfkym6P04aEugNDFNhfIVFjnN8snTnJ4dh6u0WUvBKpDOzy2LFZ/6E
         7fgUWNDRgKEfh6uaMc1YmegUREG/03XPWtd03gtwsGjnPPKCPiwBBpkO+ezXhzdRDoQa
         K2Hgv4n46oN+NCNzzH2HMB+E0VJ2FzAmt8g2eVFKLm8w2Y8AfSrFcbvumjsUVwkEo0UE
         fWbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793708083; x=1794312883;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Pf9+dqarDik/1VFNyF4qDgyRQaekTFSfrgk/fsHvIPE=;
        b=zuGgmBY8yYDNF/vHF+P3lTgqQbJJsFz/TffrQOwRVfRrxKKZt3BKLs3ECHVWhv9eMF
         hP3G/T6+X0jY2V2u20o2hiIQQLojYzwn1OLFLA00kyGSb6kvSebTmsu4wqaaHCKFLcbW
         RGcMZn64YAjChfzUsvJiGVnttnEcBu2ICbazLNRU28w89jjM/kQTv9c+ym0d0ARQrfBr
         PZ9E5KEsvDx3WM0Jv5BIS68DkaBatc/f9o38BtFmr6tjTpwrHbhs+CnDVMDQWj173Dqg
         O3/WbjKpUZnz+ewFVFjywkre2F8yPtRg8eMUlwD1kDPa3kROdmLiTubAomyYnddu3wMz
         OPZQ==
X-Gm-Message-State: APuU4Z8j6WHxhNE/SwZMMlKf++HYKR6+eVS2ABdxc8JEl15szbShfzxH
	/ExPTRVUkXbXJIGa75D+AyBudwvT8ypLafDJnVrwk9EdHyqoY2NZgHZy0ELDwGfxeXn+EQCoe6O
	AKAdcnZzQYhN3lGADcPjgpGf7584gNHE=
X-Gm-Gg: AYBFou0N3mIFm9Mh0BGst1Jf//VTfCnCqq/fb2KlnQBU6lhRdCi6WHI3FiVgACxdtEO
	7n2LRAfzvKUHP8xQpPNDogMWOzS3/0CjAniq4LZnxaXDZz2B74c9bovJRutYvBJbjFmzP39a5Am
	E2Tj9BHij+w0jOxXtaY0DniuB3Ypcdnfd/fOja05AjxRlb2buVrKMLM9haPD9GuOxjJwyY0n1RP
	sqIV93Plazd0OJqGYfsC9+oopVvIEqB4l4As7A2yHzsPJJbFulnZv/5AOP7LY5uGAOmVNd7FPqQ
	YZgtZF0GnDqBpg8iDS6pfJ5r/ZTWbKzssaSGn3tzO+HATOWvBO4nSDRKBhD+vB9lJCylvjwFx27
	pYpkx6AED9qfU10n4WrBiN1oWxTk5wO5+n5GLhD/PrePSGZXWWO8CPLXTfx+JI4eObiWUAF8=
X-Received: by 2002:a05:690c:281:b0:8ab:f06b:4150 with SMTP id
 00721157ae682-8b2b679076fmr101778067b3.57.1793708083341; Tue, 03 Nov 2026
 04:14:43 -0800 (PST)
MIME-Version: 1.0
References: <20261030103942.2373161-1-daniel.turull@ericsson.com> <20261030103942.2373161-2-daniel.turull@ericsson.com>
In-Reply-To: <20261030103942.2373161-2-daniel.turull@ericsson.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 3 Nov 2026 13:14:31 +0100
X-Gm-Features: AclHuK-Ou280E6Ccfw7CC7mX9hV5zwkhVHWEi-Mg2k23hmRm3V4VVjoIh-CxAN8
Message-ID: <CANNYZj9Gxq+rt_sc89DcuLuaTsMX8vKggOOi4zF6Uuz_in1u+A@mail.gmail.com>
Subject: Re: [AUH][PATCH v5 2/2] steps: skip changelog in commit message when
 devtool flags it
To: daniel.turull@ericsson.com
Cc: yocto-patches@lists.yoctoproject.org, jaipaul.cheernam@est.tech
Content-Type: multipart/alternative; boundary="000000000000236d2e065f5e358a"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Tue, 03 Nov 2026 12:14:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5219

--000000000000236d2e065f5e358a
Content-Type: text/plain; charset="UTF-8"

Thanks, both patches applied and pushed.

Alex

On Fri, 30 Oct 2026 at 11:39, <daniel.turull@ericsson.com> wrote:

> From: Daniel Turull <daniel.turull@ericsson.com>
>
> Some upstream changelogs are badly formed for a commit message (e.g.
> mesa, gstreamer release notes, raw git log dumps) and make the upgrade
> commits hard to read. 'devtool upgrade' now flags these, driven by
> RECIPE_UPGRADE_CHANGELOG_SKIP in OE-Core, so honour that and leave them
> out of the commit message. The changelog is still attached to the AUH
> email, so the information is not lost.
>
> This depends on the OE-Core patch "devtool: upgrade: flag badly
> formed changelogs in metadata".
>
> Assisted-by: kiro:claude-sonnet-5.5
> Signed-off-by: Daniel Turull <daniel.turull@ericsson.com>
> ---
> Changes in v5:
> - Use pkg_ctx['devtool_upgrade_metadata'] from the previous patch
> Changes in v4:
> - Use the devtool_changelog_skip field exposed in pkg_ctx by the
>   previous patch (Alexander)
> Changes in v3:
> - Parse the devtool metadata JSON once and keep it in
>   pkg_ctx['changelog_metadata'] instead of reading it in a separate
>   _changelog_skip() helper (Alexander)
> - Split the _get_changelog() refactor into a separate patch
> ---
>  modules/steps.py | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/modules/steps.py b/modules/steps.py
> index 3da8984..9dc637f 100644
> --- a/modules/steps.py
> +++ b/modules/steps.py
> @@ -106,6 +106,10 @@ def _append_changelog_to_commit_msg(group, opts):
>      for p in group['pkgs']:
>          if 'changelog_text' not in p:
>              continue
> +        # Changelog stays attached to the email, only the commit message
> skips it
> +        if p['devtool_upgrade_metadata'].get('changelog_skip'):
> +            I(" %s: changelog not added to commit message
> (RECIPE_UPGRADE_CHANGELOG_SKIP)" % p['PN'])
> +            continue
>          text = p['changelog_text'].strip()
>          # Group recipes may share a source and produce identical
> changelogs
>          # (e.g. mesa, mesa-native); skip proven duplicates, keep the rest.
>

--000000000000236d2e065f5e358a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Thanks, both patches applied and pushed.</div><div><b=
r></div><div>Alex</div></div><br><div class=3D"gmail_quote gmail_quote_cont=
ainer"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, 30 Oct 2026 at 11:39, =
&lt;<a href=3D"mailto:daniel.turull@ericsson.com">daniel.turull@ericsson.co=
m</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>From: Daniel Turull &lt;<a href=3D"mailto:daniel.turull@ericsson.com" targ=
et=3D"_blank">daniel.turull@ericsson.com</a>&gt;<br>
<br>
Some upstream changelogs are badly formed for a commit message (e.g.<br>
mesa, gstreamer release notes, raw git log dumps) and make the upgrade<br>
commits hard to read. &#39;devtool upgrade&#39; now flags these, driven by<=
br>
RECIPE_UPGRADE_CHANGELOG_SKIP in OE-Core, so honour that and leave them<br>
out of the commit message. The changelog is still attached to the AUH<br>
email, so the information is not lost.<br>
<br>
This depends on the OE-Core patch &quot;devtool: upgrade: flag badly<br>
formed changelogs in metadata&quot;.<br>
<br>
Assisted-by: kiro:claude-sonnet-5.5<br>
Signed-off-by: Daniel Turull &lt;<a href=3D"mailto:daniel.turull@ericsson.c=
om" target=3D"_blank">daniel.turull@ericsson.com</a>&gt;<br>
---<br>
Changes in v5:<br>
- Use pkg_ctx[&#39;devtool_upgrade_metadata&#39;] from the previous patch<b=
r>
Changes in v4:<br>
- Use the devtool_changelog_skip field exposed in pkg_ctx by the<br>
=C2=A0 previous patch (Alexander)<br>
Changes in v3:<br>
- Parse the devtool metadata JSON once and keep it in<br>
=C2=A0 pkg_ctx[&#39;changelog_metadata&#39;] instead of reading it in a sep=
arate<br>
=C2=A0 _changelog_skip() helper (Alexander)<br>
- Split the _get_changelog() refactor into a separate patch<br>
---<br>
=C2=A0modules/steps.py | 4 ++++<br>
=C2=A01 file changed, 4 insertions(+)<br>
<br>
diff --git a/modules/steps.py b/modules/steps.py<br>
index 3da8984..9dc637f 100644<br>
--- a/modules/steps.py<br>
+++ b/modules/steps.py<br>
@@ -106,6 +106,10 @@ def _append_changelog_to_commit_msg(group, opts):<br>
=C2=A0 =C2=A0 =C2=A0for p in group[&#39;pkgs&#39;]:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if &#39;changelog_text&#39; not in p:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Changelog stays attached to the email, only =
the commit message skips it<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if p[&#39;devtool_upgrade_metadata&#39;].get(&=
#39;changelog_skip&#39;):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 I(&quot; %s: changelog not added=
 to commit message (RECIPE_UPGRADE_CHANGELOG_SKIP)&quot; % p[&#39;PN&#39;])=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0text =3D p[&#39;changelog_text&#39;].stri=
p()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Group recipes may share a source and pr=
oduce identical changelogs<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# (e.g. mesa, mesa-native); skip proven d=
uplicates, keep the rest.<br>
</blockquote></div>

--000000000000236d2e065f5e358a--
