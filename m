Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D79D49C83
	for <webhook@archiver.kernel.org>; Fri, 30 Jan 2026 09:05:58 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6640.1769763952353164154
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 30 Jan 2026 01:05:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=N5qfBVOY;
 spf=pass (domain: smile.fr, ip: 209.85.221.45, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-432755545fcso1311094f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 30 Jan 2026 01:05:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769763950; cv=none;
        d=google.com; s=arc-20240605;
        b=VZoch5izOibFJetNfHz2dCwm1Xj+15TzcPVYUcK6EndMaug6oDbimOtVNURlf5zwQk
         ntq4LR+LdxISrBIDb1bsaS1+uA/joHCfY7loMQQd7HAKwj43YUC550CAhdiPdLn4afgM
         /FOTKep+JCFIbbP86BOK1BPNFyEP7QgC2RBAKFrXP7HERyFl6cov+YaRpZrwRzXD9i+9
         1MORLZxuZAIPVlxSV5PzIQ+iN2/Os0kRbBWg2kNqfTwDGTcXSdo5YzFjw2si71WUjaTR
         ISbXCFNwpo0pDqfrNrPESjH2XQyqrLHKud54SrSKaFJYRnu+FbYVfbzqV7aWXnT/R6pw
         /bZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=+LdkusPY7GyRN8l+DsZptXRZi64DwJegmfzzsGzI5cw=;
        fh=moagCLbVVFQO5kw1aLdWVpJz+dpYgsdIWNCHzBu4K0w=;
        b=YAiGHUvxOfHKaGLwdz900m/t/6KvYFuO5Rmb893fZLgrfNPquySQY0mqGK7xrpXlqV
         ed/U4TpPL0zMd3wTTBEAQUAebwBs/x/rcyYMS43gHSi1TufvJSIoV3jwxeRMwbfQ+2aI
         roQsN/MwQyAoLWeSc7RUAhpmy2ySmUljCbuvpDcFDquXdmx3l+dun8yIOH0HnlDd7Ozt
         AN1nzpLDQVKtfx53qb6wuxgu2apr/ejcR/GujdXZvjxn8rjqxS0R+xT+bCCuF5S61M3b
         5/rgeF2ryYC387WmlzlReIAnjy5WCyVr+rtSPaNIfWJlhwrN+er2EEZAtmqmzYNxAyO2
         61zQ==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1769763950; x=1770368750; darn=lists.yoctoproject.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+LdkusPY7GyRN8l+DsZptXRZi64DwJegmfzzsGzI5cw=;
        b=N5qfBVOYoTXXQ2a0yYQBQqRuwWeZKjbXctJkBnNEw/IRy/uT36QZsK+OGoPlXAZaH6
         DQTc0HP2IbtRRjc2va8zW4LAqo0mS6uNI1VF+n26Yl9G0kEJwVLdOhyl9BZy2Bvl3Yhj
         lnfQB5oaZCbPM+Nd+qNDPao8vNa9NxbFjqcQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769763950; x=1770368750;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+LdkusPY7GyRN8l+DsZptXRZi64DwJegmfzzsGzI5cw=;
        b=Xx535aKz/RiwAZmiDUlgr/Eo5v5oaKVvoSiDK+r/ATJ08oJ5g8X7LRHvHYDTtFmQsX
         KhcRztHkhqyaRHwatCynNh4sDXm+MFYDVHUIOWy8OyOAybk6msMHRtwOsEJXzCfBBb5t
         pDU6MKUZftmAWXkaresNz3kdCyXIRkHbgvoYZ6nooqHdyHfv1WkeuXdca5PYe2BSLgSe
         CC8HGgqH6Jl7+VSK8lwZ03hOQ7lpbmxdrXthGduar9QFep6W9v+1zlxLvGZUPJTkuu/E
         ocu2KaFxG0oAVZoPFZDNe5FXhqn2AHvkUwRdbuI0RqE1fJO3GEMtaaVbyog9cAkh91lH
         o2fw==
X-Gm-Message-State: AOJu0Yzm48Jt0XWvwdNSW28oKHjqaihU/Ydm/dd7/nj4AA1Uc8bFNR9k
	bA6iSZyhAt5ZX/3PVf7qmhiNz8PUSw+BSicLeuPXiZoXMFa1eFwwHWByWoVGOiKIUePliMdMRA5
	+QfBqdHuh4q4L0+zG3z/SjjYLaoLwH46yYNAD2wpdFfzWxBbdBMnIuqk=
X-Gm-Gg: AZuq6aIudz17rIF+9Ut30eIqAf3G6MYqccWfR3w01KpetsrphE65S3L0ij2K6pMpCiY
	6rAxTBqEX8u7Xxc9Qd2OmjU7EG9uXye8cZy1Rtk607DFeyP9A6+49nnPGl8lmnayWscm2dkgh//
	K2BowNtw8slchlChJhr44sKOxuZsQwWT8ifQsxw3YKA1JYBzZ45OkVU/Ym9IOWdrBhPOn9DJfnt
	XWxQA4gg83XKloM74d96e+EeJZM5m6yY9LhNX7yajJQKSsaZFKE3sSPAHpffwpwP9I7FL7NPTCH
	y/w5bn80rxfo07IjCeuCdF/TXN87
X-Received: by 2002:a05:6000:240e:b0:435:9653:e154 with SMTP id
 ffacd0b85a97d-435f3a8823amr3539506f8f.27.1769763949978; Fri, 30 Jan 2026
 01:05:49 -0800 (PST)
MIME-Version: 1.0
References: <20260129163632.1660116-1-ross.burton@arm.com> <CAMSfU+59XSRn+Zg=CtW2L5LVrVZybNS1bQZaW0RJxcELYkX-_Q@mail.gmail.com>
In-Reply-To: <CAMSfU+59XSRn+Zg=CtW2L5LVrVZybNS1bQZaW0RJxcELYkX-_Q@mail.gmail.com>
From: Yoann Congal <yoann.congal@smile.fr>
Date: Fri, 30 Jan 2026 10:05:23 +0100
X-Gm-Features: AZwV_Qg-CQL0oVgaUqver-qUebLFv5NCec20vJvkW3fHxd0mActIWOS_AUF4ZDU
Message-ID: <CAMSfU+5-KDEkMTanAvx8jsSmLrNThu8Zryip2g_1o2V9ENUbSw@mail.gmail.com>
Subject: Re: [yocto-patches] [PATCH yocto-autobuilder-helper kirkstone]
 scripts: rebase before pushing patch and CVE metrics
To: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="0000000000009337990649974769"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 30 Jan 2026 09:05:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3151

--0000000000009337990649974769
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 29 janv. 2026 =C3=A0 18:07, Yoann Congal <yoann.congal@smile.fr> a
=C3=A9crit :

>
>
> Le jeu. 29 janv. 2026 =C3=A0 17:37, Ross Burton via lists.yoctoproject.or=
g
> <ross.burton=3Darm.com@lists.yoctoproject.org> a =C3=A9crit :
>
>> There's a chance that run-cvecheck and run-patchmetrics fail to push
>> because the remote repository has changed. Try to resolve this by pullin=
g
>> and rebasing immediately before the push, and failing if we can't rebase=
.
>>
>> Backport of 60e2011 from master.
>>
>> [ YOCTO #15686 ]
>>
>> Signed-off-by: Ross Burton <ross.burton@arm.com>
>>
>
> Thanks Ross,
>
> I missed that when fixing
> https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D16111 (on Dunfell)
>
> There is a now obsolete comment to remove/rephrase:
>
> # Do another pull to make sure we're as up to date as possible.  This is#=
 preferable to committing and rebasing before pushing as it would be better=
 to# waste some time repeating work than commit potentially corrupted files=
 from a# git merge gone wrong.
>
>
> But, this is also the case on master. I plan to send a patch someday.
>

Also, shouldn't we do the same for the other code path? (if "$BRANCH" =3D
"master" to update cve-count-byday.json)
https://git.yoctoproject.org/yocto-autobuilder-helper/tree/scripts/run-cvec=
heck#n106


>
> ---
>>  scripts/run-cvecheck     | 4 ++++
>>  scripts/run-patchmetrics | 5 +++++
>>  2 files changed, 9 insertions(+)
>>
>> diff --git a/scripts/run-cvecheck b/scripts/run-cvecheck
>> index d22dc825..c6b00660 100755
>> --- a/scripts/run-cvecheck
>> +++ b/scripts/run-cvecheck
>> @@ -90,6 +90,10 @@ if [ -e tmp/log/cve/cve-summary.json ]; then
>>      git -C $METRICSDIR add cve-check/$BRANCH/$TIMESTAMP.json
>>      git -C $METRICSDIR commit -asm "Autobuilder adding new CVE data for
>> branch $BRANCH" || true
>>      if [ "$PUSH" =3D "1" ]; then
>> +        if ! git -C $METRICSDIR pull --rebase; then
>> +            echo "Aborting push, metrics repo has updated and cannot
>> rebase cleanly"
>> +            exit 1
>> +        fi
>>          git -C $METRICSDIR push
>>      fi
>>      $OURDIR/cve-report.py tmp/log/cve/cve-summary.json >
>> $RESULTSDIR/cve-status-$BRANCH.txt
>> diff --git a/scripts/run-patchmetrics b/scripts/run-patchmetrics
>> index 391ac45a..5fe3d8f3 100755
>> --- a/scripts/run-patchmetrics
>> +++ b/scripts/run-patchmetrics
>> @@ -24,6 +24,11 @@ if [ ! -e $PARENTDIR/yocto-metrics ]; then
>>  fi
>>  $OURDIR/patchmetrics-update --repo $PARENTDIR --patchscript
>> $PARENTDIR/scripts/contrib/patchreview.py --metadata $TARGETDIR --json
>> $PARENTDIR/yocto-metrics/patch-status.json
>>  git -C $PARENTDIR/yocto-metrics commit -asm "Autobuilder adding new
>> patch stats"
>> +
>> +if ! git -C $PARENTDIR/yocto-metrics pull --rebase; then
>> +    echo "Aborting push, metrics repo has updated and cannot rebase
>> cleanly"
>> +    exit 1
>> +fi
>>  git -C $PARENTDIR/yocto-metrics push
>>
>>  if [ ! -d $RESULTSDIR ]; then
>> --
>> 2.43.0
>>
>>
>>
>> ------------
>> Links: You receive all messages sent to this group.
>> View/Reply Online (#3143):
>> https://lists.yoctoproject.org/g/yocto-patches/message/3143
>> Mute This Topic: https://lists.yoctoproject.org/mt/117528934/4316185
>> Group Owner: yocto-patches+owner@lists.yoctoproject.org
>> Unsubscribe:
>> https://lists.yoctoproject.org/g/yocto-patches/leave/13179410/4316185/92=
9767106/xyzzy
>> [yoann.congal@smile.fr]
>> ------------
>>
>>
>>
>
> --
> Yoann Congal
> Smile ECS
>


--=20
Yoann Congal
Smile ECS

--0000000000009337990649974769
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">Le=C2=A0jeu. 29=
 janv. 2026 =C3=A0=C2=A018:07, Yoann Congal &lt;<a href=3D"mailto:yoann.con=
gal@smile.fr">yoann.congal@smile.fr</a>&gt; a =C3=A9crit=C2=A0:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=
=3D"ltr"><br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">Le=C2=A0jeu. 29 janv. 2026 =C3=A0=C2=A017:37, Ross Burton via =
<a href=3D"http://lists.yoctoproject.org" target=3D"_blank">lists.yoctoproj=
ect.org</a> &lt;ross.burton=3D<a href=3D"mailto:arm.com@lists.yoctoproject.=
org" target=3D"_blank">arm.com@lists.yoctoproject.org</a>&gt; a =C3=A9crit=
=C2=A0:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">There&#3=
9;s a chance that run-cvecheck and run-patchmetrics fail to push<br>
because the remote repository has changed. Try to resolve this by pulling<b=
r>
and rebasing immediately before the push, and failing if we can&#39;t rebas=
e.<br>
<br>
Backport of 60e2011 from master.<br>
<br>
[ YOCTO #15686 ]<br>
<br>
Signed-off-by: Ross Burton &lt;<a href=3D"mailto:ross.burton@arm.com" targe=
t=3D"_blank">ross.burton@arm.com</a>&gt;<br>
</blockquote><div><br></div><div>Thanks Ross,</div><div><br></div><div>I mi=
ssed that when fixing=C2=A0<a href=3D"https://bugzilla.yoctoproject.org/sho=
w_bug.cgi?id=3D16111" target=3D"_blank">https://bugzilla.yoctoproject.org/s=
how_bug.cgi?id=3D16111</a> (on Dunfell)</div><div><br></div><div>There is a=
 now obsolete comment to remove/rephrase:</div><div><pre><code><pre><span>#=
 Do another pull to make sure we&#39;re as up to date as possible.  This is=
</span>
<span># preferable to committing and rebasing before pushing as it would be=
 better to</span>
<span># waste some time repeating work than commit potentially corrupted fi=
les from a</span>
<span># git merge gone wrong.</span></pre></code></pre><br></div><div>But, =
this is also the case on master. I plan=C2=A0to send a patch someday.</div>=
</div></div></blockquote><div><br></div><div>Also, shouldn&#39;t we do the =
same for the other code path? (if &quot;$BRANCH&quot; =3D &quot;master&quot=
; to update cve-count-byday.json)</div><div><a href=3D"https://git.yoctopro=
ject.org/yocto-autobuilder-helper/tree/scripts/run-cvecheck#n106">https://g=
it.yoctoproject.org/yocto-autobuilder-helper/tree/scripts/run-cvecheck#n106=
</a></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
"><div dir=3D"ltr"><div class=3D"gmail_quote"><div><br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">---<br>
=C2=A0scripts/run-cvecheck=C2=A0 =C2=A0 =C2=A0| 4 ++++<br>
=C2=A0scripts/run-patchmetrics | 5 +++++<br>
=C2=A02 files changed, 9 insertions(+)<br>
<br>
diff --git a/scripts/run-cvecheck b/scripts/run-cvecheck<br>
index d22dc825..c6b00660 100755<br>
--- a/scripts/run-cvecheck<br>
+++ b/scripts/run-cvecheck<br>
@@ -90,6 +90,10 @@ if [ -e tmp/log/cve/cve-summary.json ]; then<br>
=C2=A0 =C2=A0 =C2=A0git -C $METRICSDIR add cve-check/$BRANCH/$TIMESTAMP.jso=
n<br>
=C2=A0 =C2=A0 =C2=A0git -C $METRICSDIR commit -asm &quot;Autobuilder adding=
 new CVE data for branch $BRANCH&quot; || true<br>
=C2=A0 =C2=A0 =C2=A0if [ &quot;$PUSH&quot; =3D &quot;1&quot; ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ! git -C $METRICSDIR pull --rebase; then<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo &quot;Aborting push, metric=
s repo has updated and cannot rebase cleanly&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit 1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fi<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0git -C $METRICSDIR push<br>
=C2=A0 =C2=A0 =C2=A0fi<br>
=C2=A0 =C2=A0 =C2=A0$OURDIR/cve-report.py tmp/log/cve/cve-summary.json &gt;=
 $RESULTSDIR/cve-status-$BRANCH.txt<br>
diff --git a/scripts/run-patchmetrics b/scripts/run-patchmetrics<br>
index 391ac45a..5fe3d8f3 100755<br>
--- a/scripts/run-patchmetrics<br>
+++ b/scripts/run-patchmetrics<br>
@@ -24,6 +24,11 @@ if [ ! -e $PARENTDIR/yocto-metrics ]; then<br>
=C2=A0fi<br>
=C2=A0$OURDIR/patchmetrics-update --repo $PARENTDIR --patchscript $PARENTDI=
R/scripts/contrib/patchreview.py --metadata $TARGETDIR --json $PARENTDIR/yo=
cto-metrics/patch-status.json<br>
=C2=A0git -C $PARENTDIR/yocto-metrics commit -asm &quot;Autobuilder adding =
new patch stats&quot;<br>
+<br>
+if ! git -C $PARENTDIR/yocto-metrics pull --rebase; then<br>
+=C2=A0 =C2=A0 echo &quot;Aborting push, metrics repo has updated and canno=
t rebase cleanly&quot;<br>
+=C2=A0 =C2=A0 exit 1<br>
+fi<br>
=C2=A0git -C $PARENTDIR/yocto-metrics push<br>
<br>
=C2=A0if [ ! -d $RESULTSDIR ]; then<br>
-- <br>
2.43.0<br>
<br>
<br>
<br>
------------<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#3143): <a href=3D"https://lists.yoctoproject.org/g/yoct=
o-patches/message/3143" rel=3D"noreferrer" target=3D"_blank">https://lists.=
yoctoproject.org/g/yocto-patches/message/3143</a><br>
Mute This Topic: <a href=3D"https://lists.yoctoproject.org/mt/117528934/431=
6185" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/m=
t/117528934/4316185</a><br>
Group Owner: <a href=3D"mailto:yocto-patches%2Bowner@lists.yoctoproject.org=
" target=3D"_blank">yocto-patches+owner@lists.yoctoproject.org</a><br>
Unsubscribe: <a href=3D"https://lists.yoctoproject.org/g/yocto-patches/leav=
e/13179410/4316185/929767106/xyzzy" rel=3D"noreferrer" target=3D"_blank">ht=
tps://lists.yoctoproject.org/g/yocto-patches/leave/13179410/4316185/9297671=
06/xyzzy</a> [<a href=3D"mailto:yoann.congal@smile.fr" target=3D"_blank">yo=
ann.congal@smile.fr</a>]<br>
------------<br>
<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><br><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"Raleway, regular">Yoann Congal</font><div><fon=
t face=3D"Raleway, regular">Smile ECS</font></div></div></div></div>
</blockquote></div><div><br clear=3D"all"></div><br><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"Raleway, regular">Yoann Congal</font><div><fon=
t face=3D"Raleway, regular">Smile ECS</font></div></div></div></div>

--0000000000009337990649974769--

