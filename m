Return-Path: <rybczynska@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6874ACAC5B8
	for <webhook@archiver.kernel.org>; Tue, 30 Sep 2025 04:20:27 +0000 (UTC)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
 by mx.groups.io with SMTP id smtpd.web11.17474.1759206023020572345
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 29 Sep 2025 21:20:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=NNXtXaN6;
 spf=pass (domain: gmail.com, ip: 209.85.215.174, mailfrom: rybczynska@gmail.com)
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b49c1c130c9so3790622a12.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 29 Sep 2025 21:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759206022; x=1759810822; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QMBoYUMPWZ0z9W7vO0GG0VWWKGtar4nSU7YufwIQuZw=;
        b=NNXtXaN68/8LB62rH2iBhi7577fATkC9ADNsJ7eWubGSfSyxDs27vPfXr2XLQWIoMo
         jcSYzAh0pUaRc3d225fj0/vKL8fIRokuerC2qwYdYdgygvn8Ls2Axp3oJGUoH+2RkfWO
         yOtjM3GDsW6YCWwQmNrr9hKD/XfeE4bRMBP1JXaSG5LnGIZqaRfArULJWvSsOv64Fg8y
         unfQeFe72wkLM9JuQCKxHzVZg0an5IcrxaGKXZxS5bIaIT3I1Zn9J04ImB9J0/olnRTa
         m+p9dz5VosnFkRXLAzMumrMFfl3Iy+V3ml8iNNIZUBwP7HpRzVColQ4FQX61ADEw9c7N
         HqKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759206022; x=1759810822;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QMBoYUMPWZ0z9W7vO0GG0VWWKGtar4nSU7YufwIQuZw=;
        b=bmwZySkKSf5VDU64DgS0yzL+E6wDuqxKlzlyULN9qlSy7qmpAy/+GNq2YOnyanXHGi
         KWQ4NawecUffQNqOwVmjt4hVKexw2gfkUGLGw+iZL3xSc86/t9EumloSndDYSEMY60xN
         gI+DSp0UoLIL+UT0XaZD4FKMY/TR1xFv9sCsn8D+yUBuLKxeIYZQde6NrBHbrbNDY0kd
         3B+nzn0pxiorVvEqCch3Fw1L6k3y/5mTIoe/hdgDFLIo5GK9//7JPN6W21QQNy7+puxX
         oD7qG4tYzulLST5uWetMeah39xBhyC9vKjomqkhue57QQABpzJKdou2j7p7f29T/qAh5
         YUKA==
X-Gm-Message-State: AOJu0YydEG5v2Dhnth7oe9qBDA9DuR39b7xBbkMTnnBfDXI2lk7J1w/f
	LH2egQL+U5jWHpywEdpgoBqv5Xg8VaKkzBq3IrbmY+nqDBJJ7nmdJwiNpVz7AJjLVyF31nRPNcM
	9XIELVQek4hSEMYa0v1Gj0bonPrmRMLg=
X-Gm-Gg: ASbGncv0wh1KQmqN+EbprqBd7u7RxgDr2oxBkdVV5zDNCYjiUPhIZnBwt5Goz1WWj1x
	XA6XTgg6EuDBlEXbLR5NyhCe9mPSYzwjdfkF+9z9LKl0ppsmtuOXBe0/pM/SBd6EDPSERRR10Iy
	wn6cADO4B+UFlkh9/AMRAERh0n5kSoB4FdN5XmFqchoL17+wyeBxTLCyCY3L8nn2XRjsmN2e7y8
	IMXCB181kSpKDhYGbolsUflEHDDkStliopAO2KUCn7ar0m/3gFsdyHto1KLyaIBio8L7aMg3Xet
	8mDfq3ri09nT/8/NDg==
X-Google-Smtp-Source: AGHT+IHBQh5mlhtycsM5Dv9qpbwqLDX6fAd1lrH3+xmIefBnY8C6vTbrcEYwhUWr7XMgxVZkdm9YFGRxUjat9idn/oo=
X-Received: by 2002:a17:903:19ef:b0:25d:885:5b6b with SMTP id
 d9443c01a7336-27ed4a76e9emr228882305ad.58.1759206022325; Mon, 29 Sep 2025
 21:20:22 -0700 (PDT)
MIME-Version: 1.0
References: <fc0c6979-568e-47a1-9906-f93e58312147@gmail.com>
In-Reply-To: <fc0c6979-568e-47a1-9906-f93e58312147@gmail.com>
From: Marta Rybczynska <rybczynska@gmail.com>
Date: Tue, 30 Sep 2025 06:20:10 +0200
X-Gm-Features: AS18NWADI87Xas7Kcg6KjfHyoz-n5IHGCAt2ym-D_KEj-5cVMMhLRHtdpuMeoU4
Message-ID: <CAApg2=QwFvY1=7YZUZJGF8SDqizTQ=1rHRPY0brdzMgVy-ZpZA@mail.gmail.com>
Subject: Re: [meta-security][PATCH v2] suricata-update: add package to pull files
To: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Cc: yocto-patches@lists.yoctoproject.org, scott.murray@konsulko.com
Content-Type: multipart/alternative; boundary="0000000000000c28e7063ffd1296"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 30 Sep 2025 04:20:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2260

--0000000000000c28e7063ffd1296
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,
Thank you for the patch, I take it to my testing branch.

Kind regards,
Marta

On Mon, Sep 22, 2025 at 5:04=E2=80=AFPM Clayton Casciato <
majortomtosourcecontrol@gmail.com> wrote:

> suricata has "--disable-suricata-update"
>
> Original add: caaeb67863a6 ("suricata-update: add package to pull rules")
> Suricata dropped: 7a1691c03726 ("suricata: Drop 4.1.x its EOL")
> Not readded: 818a8646a689 ("suricata: rust is in core")
>
> *Changes*
> 1.2.1 -> 1.3.6
> Drop period and trailing space in SUMMARY value
> Drop now-redundant "S"
> Use HTTPS protocol for SRC_URI
> LICENSE "GPLv2" -> "GPL-2.0-only"
> Add "python3-shell" RDEPENDS to resolve:
>   ModuleNotFoundError: No module named 'shlex'
>
> Basic target testing:
> root@beaglebone-yocto:~# suricata-update
> 22/9/2025 -- 04:06:23 - <Info> -- Using data-directory /var/lib/suricata.
> 22/9/2025 -- 04:06:23 - <Info> -- Using Suricata configuration
> /etc/suricata/suricata.yaml
> 22/9/2025 -- 04:06:23 - <Info> -- Using /usr/share/suricata/rules for
> Suricata provided rules.
> 22/9/2025 -- 04:06:23 - <Info> -- Found Suricata version 7.0.0 at
> /bin/suricata.
> 22/9/2025 -- 04:06:23 - <Info> -- Loading /etc/suricata/suricata.yaml
> 22/9/2025 -- 04:06:23 - <Info> -- Disabling rules for protocol pgsql
> 22/9/2025 -- 04:06:23 - <Info> -- Disabling rules for protocol modbus
> 22/9/2025 -- 04:06:23 - <Info> -- Disabling rules for protocol dnp3
> 22/9/2025 -- 04:06:23 - <Info> -- Disabling rules for protocol enip
> 22/9/2025 -- 04:06:23 - <Info> -- No sources configured, will use Emergin=
g
> Threats Open
> 22/9/2025 -- 04:06:23 - <Info> -- Fetching
> https://rules.emergingthreats.net/open/suricata-7.0.0/emerging.rules.tar.=
gz
> .
>  100% - 5102134/5102134
> 22/9/2025 -- 04:06:24 - <Info> -- Done.
> 22/9/2025 -- 04:06:25 - <Info> -- Loading distribution rule file
> /usr/share/suricata/rules/app-layer-events.rules
> 22/9/2025 -- 04:06:25 - <Info> -- Loading distribution rule file
> /usr/share/suricata/rules/decoder-events.rules
> 22/9/2025 -- 04:06:25 - <Info> -- Loading distribution rule file
> /usr/share/suricata/rules/dhcp-events.rules
> 22/9/2025 -- 04:06:25 - <Info> -- Loading distribution rule file
> /usr/share/suricata/rules/dnp3-events.rules
> 22/9/2025 -- 04:06:25 - <Info> -- Loading distribution rule file
> /usr/share/suricata/rules/dns-events.rules
> 22/9/2025 -- 04:06:25 - <Info> -- Loading distribution rule file
> /usr/share/suricata/rules/files.rules
> 22/9/2025 -- 04:06:25 - <Info> -- Loading distribution rule file
> /usr/share/suricata/rules/http2-events.rules
> 22/9/2025 -- 04:06:25 - <Info> -- Loading distribution rule file
> /usr/share/suricata/rules/http-events.rules
> 22/9/2025 -- 04:06:25 - <Info> -- Loading distribution rule file
> /usr/share/suricata/rules/ipsec-events.rules
> 22/9/2025 -- 04:06:25 - <Info> -- Loading distribution rule file
> /usr/share/suricata/rules/kerberos-events.rules
> 22/9/2025 -- 04:06:25 - <Info> -- Loading distribution rule file
> /usr/share/suricata/rules/modbus-events.rules
> 22/9/2025 -- 04:06:25 - <Info> -- Loading distribution rule file
> /usr/share/suricata/rules/mqtt-events.rules
> 22/9/2025 -- 04:06:25 - <Info> -- Loading distribution rule file
> /usr/share/suricata/rules/nfs-events.rules
> 22/9/2025 -- 04:06:25 - <Info> -- Loading distribution rule file
> /usr/share/suricata/rules/ntp-events.rules
> 22/9/2025 -- 04:06:25 - <Info> -- Loading distribution rule file
> /usr/share/suricata/rules/quic-events.rules
> 22/9/2025 -- 04:06:25 - <Info> -- Loading distribution rule file
> /usr/share/suricata/rules/rfb-events.rules
> 22/9/2025 -- 04:06:25 - <Info> -- Loading distribution rule file
> /usr/share/suricata/rules/smb-events.rules
> 22/9/2025 -- 04:06:25 - <Info> -- Loading distribution rule file
> /usr/share/suricata/rules/smtp-events.rules
> 22/9/2025 -- 04:06:25 - <Info> -- Loading distribution rule file
> /usr/share/suricata/rules/ssh-events.rules
> 22/9/2025 -- 04:06:25 - <Info> -- Loading distribution rule file
> /usr/share/suricata/rules/stream-events.rules
> 22/9/2025 -- 04:06:25 - <Info> -- Loading distribution rule file
> /usr/share/suricata/rules/tls-events.rules
> 22/9/2025 -- 04:06:27 - <Info> -- Ignoring file
> ba1345f233851ca2df4d905ea4b386d2/rules/emerging-deleted.rules
> 22/9/2025 -- 04:06:57 - <Info> -- Loaded 61205 rules.
> 22/9/2025 -- 04:07:02 - <Info> -- Disabled 14 rules.
> 22/9/2025 -- 04:07:02 - <Info> -- Enabled 0 rules.
> 22/9/2025 -- 04:07:02 - <Info> -- Modified 0 rules.
> 22/9/2025 -- 04:07:02 - <Info> -- Dropped 0 rules.
> 22/9/2025 -- 04:07:03 - <Info> -- Enabled 136 rules for flowbit
> dependencies.
> 22/9/2025 -- 04:07:03 - <Info> -- Creating directory
> /var/lib/suricata/rules.
> 22/9/2025 -- 04:07:03 - <Info> -- Backing up current rules.
> 22/9/2025 -- 04:07:03 - <Info> -- Writing rules to
> /var/lib/suricata/rules/suricata.rules: total: 61205; enabled: 45406;
> added: 61205; removed 0; modified: 0
> 22/9/2025 -- 04:07:06 - <Info> -- Writing
> /var/lib/suricata/rules/classification.config
> 22/9/2025 -- 04:07:07 - <Info> -- Testing with suricata -T.
> 22/9/2025 -- 04:07:57 - <Info> -- Done.
>
> Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
> ---
>
> Sponsor: 21SoftWare LLC
>
> v2: 1.3.4 -> 1.3.6, drop "S", document target test results
> v1: https://lists.yoctoproject.org/g/yocto-patches/message/1569
>
>  .../suricata/python3-suricata-update_1.3.6.bb     | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>  create mode 100644 recipes-ids/suricata/python3-suricata-update_1.3.6.bb
>
> diff --git a/recipes-ids/suricata/python3-suricata-update_1.3.6.bb
> b/recipes-ids/suricata/python3-suricata-update_1.3.6.bb
> new file mode 100644
> index 0000000..cdf2faa
> --- /dev/null
> +++ b/recipes-ids/suricata/python3-suricata-update_1.3.6.bb
> @@ -0,0 +1,15 @@
> +SUMMARY =3D "The tool for updating your Suricata rules"
> +HOMEPAGE =3D "http://suricata-ids.org/"
> +SECTION =3D "security Monitor/Admin"
> +LICENSE =3D "GPL-2.0-only"
> +
> +LIC_FILES_CHKSUM =3D
> "file://LICENSE;beginline=3D1;endline=3D2;md5=3Dc70d8d3310941dcdfcd1e0280=
0a1f548"
> +
> +SRCREV =3D "f76a61bdee69961537585a1036c4294da28495a5"
> +SRC_URI =3D "git://
> github.com/OISF/suricata-update;protocol=3Dhttps;branch=3Dmaster"
> +
> +inherit python3native python3targetconfig setuptools3
> +
> +RDEPENDS:${PN} =3D "python3-pyyaml python3-logging python3-compression
> python3-shell"
> +
> +BBCLASSEXTEND =3D "native nativesdk"
>

--0000000000000c28e7063ffd1296
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello,</div><div>Thank you for the patch, I take it t=
o my testing branch.</div><div><br></div><div>Kind regards,</div><div>Marta=
<br></div></div><br><div class=3D"gmail_quote gmail_quote_container"><div d=
ir=3D"ltr" class=3D"gmail_attr">On Mon, Sep 22, 2025 at 5:04=E2=80=AFPM Cla=
yton Casciato &lt;<a href=3D"mailto:majortomtosourcecontrol@gmail.com">majo=
rtomtosourcecontrol@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">suricata has &quot;--disable-suricata-update&q=
uot;<br>
<br>
Original add: caaeb67863a6 (&quot;suricata-update: add package to pull rule=
s&quot;)<br>
Suricata dropped: 7a1691c03726 (&quot;suricata: Drop 4.1.x its EOL&quot;)<b=
r>
Not readded: 818a8646a689 (&quot;suricata: rust is in core&quot;)<br>
<br>
*Changes*<br>
1.2.1 -&gt; 1.3.6<br>
Drop period and trailing space in SUMMARY value<br>
Drop now-redundant &quot;S&quot;<br>
Use HTTPS protocol for SRC_URI<br>
LICENSE &quot;GPLv2&quot; -&gt; &quot;GPL-2.0-only&quot;<br>
Add &quot;python3-shell&quot; RDEPENDS to resolve:<br>
=C2=A0 ModuleNotFoundError: No module named &#39;shlex&#39;<br>
<br>
Basic target testing:<br>
root@beaglebone-yocto:~# suricata-update<br>
22/9/2025 -- 04:06:23 - &lt;Info&gt; -- Using data-directory /var/lib/suric=
ata.<br>
22/9/2025 -- 04:06:23 - &lt;Info&gt; -- Using Suricata configuration /etc/s=
uricata/suricata.yaml<br>
22/9/2025 -- 04:06:23 - &lt;Info&gt; -- Using /usr/share/suricata/rules for=
 Suricata provided rules.<br>
22/9/2025 -- 04:06:23 - &lt;Info&gt; -- Found Suricata version 7.0.0 at /bi=
n/suricata.<br>
22/9/2025 -- 04:06:23 - &lt;Info&gt; -- Loading /etc/suricata/suricata.yaml=
<br>
22/9/2025 -- 04:06:23 - &lt;Info&gt; -- Disabling rules for protocol pgsql<=
br>
22/9/2025 -- 04:06:23 - &lt;Info&gt; -- Disabling rules for protocol modbus=
<br>
22/9/2025 -- 04:06:23 - &lt;Info&gt; -- Disabling rules for protocol dnp3<b=
r>
22/9/2025 -- 04:06:23 - &lt;Info&gt; -- Disabling rules for protocol enip<b=
r>
22/9/2025 -- 04:06:23 - &lt;Info&gt; -- No sources configured, will use Eme=
rging Threats Open<br>
22/9/2025 -- 04:06:23 - &lt;Info&gt; -- Fetching <a href=3D"https://rules.e=
mergingthreats.net/open/suricata-7.0.0/emerging.rules.tar.gz" rel=3D"norefe=
rrer" target=3D"_blank">https://rules.emergingthreats.net/open/suricata-7.0=
.0/emerging.rules.tar.gz</a>.<br>
=C2=A0100% - 5102134/5102134<br>
22/9/2025 -- 04:06:24 - &lt;Info&gt; -- Done.<br>
22/9/2025 -- 04:06:25 - &lt;Info&gt; -- Loading distribution rule file /usr=
/share/suricata/rules/app-layer-events.rules<br>
22/9/2025 -- 04:06:25 - &lt;Info&gt; -- Loading distribution rule file /usr=
/share/suricata/rules/decoder-events.rules<br>
22/9/2025 -- 04:06:25 - &lt;Info&gt; -- Loading distribution rule file /usr=
/share/suricata/rules/dhcp-events.rules<br>
22/9/2025 -- 04:06:25 - &lt;Info&gt; -- Loading distribution rule file /usr=
/share/suricata/rules/dnp3-events.rules<br>
22/9/2025 -- 04:06:25 - &lt;Info&gt; -- Loading distribution rule file /usr=
/share/suricata/rules/dns-events.rules<br>
22/9/2025 -- 04:06:25 - &lt;Info&gt; -- Loading distribution rule file /usr=
/share/suricata/rules/files.rules<br>
22/9/2025 -- 04:06:25 - &lt;Info&gt; -- Loading distribution rule file /usr=
/share/suricata/rules/http2-events.rules<br>
22/9/2025 -- 04:06:25 - &lt;Info&gt; -- Loading distribution rule file /usr=
/share/suricata/rules/http-events.rules<br>
22/9/2025 -- 04:06:25 - &lt;Info&gt; -- Loading distribution rule file /usr=
/share/suricata/rules/ipsec-events.rules<br>
22/9/2025 -- 04:06:25 - &lt;Info&gt; -- Loading distribution rule file /usr=
/share/suricata/rules/kerberos-events.rules<br>
22/9/2025 -- 04:06:25 - &lt;Info&gt; -- Loading distribution rule file /usr=
/share/suricata/rules/modbus-events.rules<br>
22/9/2025 -- 04:06:25 - &lt;Info&gt; -- Loading distribution rule file /usr=
/share/suricata/rules/mqtt-events.rules<br>
22/9/2025 -- 04:06:25 - &lt;Info&gt; -- Loading distribution rule file /usr=
/share/suricata/rules/nfs-events.rules<br>
22/9/2025 -- 04:06:25 - &lt;Info&gt; -- Loading distribution rule file /usr=
/share/suricata/rules/ntp-events.rules<br>
22/9/2025 -- 04:06:25 - &lt;Info&gt; -- Loading distribution rule file /usr=
/share/suricata/rules/quic-events.rules<br>
22/9/2025 -- 04:06:25 - &lt;Info&gt; -- Loading distribution rule file /usr=
/share/suricata/rules/rfb-events.rules<br>
22/9/2025 -- 04:06:25 - &lt;Info&gt; -- Loading distribution rule file /usr=
/share/suricata/rules/smb-events.rules<br>
22/9/2025 -- 04:06:25 - &lt;Info&gt; -- Loading distribution rule file /usr=
/share/suricata/rules/smtp-events.rules<br>
22/9/2025 -- 04:06:25 - &lt;Info&gt; -- Loading distribution rule file /usr=
/share/suricata/rules/ssh-events.rules<br>
22/9/2025 -- 04:06:25 - &lt;Info&gt; -- Loading distribution rule file /usr=
/share/suricata/rules/stream-events.rules<br>
22/9/2025 -- 04:06:25 - &lt;Info&gt; -- Loading distribution rule file /usr=
/share/suricata/rules/tls-events.rules<br>
22/9/2025 -- 04:06:27 - &lt;Info&gt; -- Ignoring file ba1345f233851ca2df4d9=
05ea4b386d2/rules/emerging-deleted.rules<br>
22/9/2025 -- 04:06:57 - &lt;Info&gt; -- Loaded 61205 rules.<br>
22/9/2025 -- 04:07:02 - &lt;Info&gt; -- Disabled 14 rules.<br>
22/9/2025 -- 04:07:02 - &lt;Info&gt; -- Enabled 0 rules.<br>
22/9/2025 -- 04:07:02 - &lt;Info&gt; -- Modified 0 rules.<br>
22/9/2025 -- 04:07:02 - &lt;Info&gt; -- Dropped 0 rules.<br>
22/9/2025 -- 04:07:03 - &lt;Info&gt; -- Enabled 136 rules for flowbit depen=
dencies.<br>
22/9/2025 -- 04:07:03 - &lt;Info&gt; -- Creating directory /var/lib/suricat=
a/rules.<br>
22/9/2025 -- 04:07:03 - &lt;Info&gt; -- Backing up current rules.<br>
22/9/2025 -- 04:07:03 - &lt;Info&gt; -- Writing rules to /var/lib/suricata/=
rules/suricata.rules: total: 61205; enabled: 45406; added: 61205; removed 0=
; modified: 0<br>
22/9/2025 -- 04:07:06 - &lt;Info&gt; -- Writing /var/lib/suricata/rules/cla=
ssification.config<br>
22/9/2025 -- 04:07:07 - &lt;Info&gt; -- Testing with suricata -T.<br>
22/9/2025 -- 04:07:57 - &lt;Info&gt; -- Done.<br>
<br>
Signed-off-by: Clayton Casciato &lt;<a href=3D"mailto:majortomtosourcecontr=
ol@gmail.com" target=3D"_blank">majortomtosourcecontrol@gmail.com</a>&gt;<b=
r>
---<br>
<br>
Sponsor: 21SoftWare LLC<br>
<br>
v2: 1.3.4 -&gt; 1.3.6, drop &quot;S&quot;, document target test results<br>
v1: <a href=3D"https://lists.yoctoproject.org/g/yocto-patches/message/1569"=
 rel=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/g/yoct=
o-patches/message/1569</a><br>
<br>
=C2=A0.../suricata/<a href=3D"http://python3-suricata-update_1.3.6.bb" rel=
=3D"noreferrer" target=3D"_blank">python3-suricata-update_1.3.6.bb</a>=C2=
=A0 =C2=A0 =C2=A0| 15 +++++++++++++++<br>
=C2=A01 file changed, 15 insertions(+)<br>
=C2=A0create mode 100644 recipes-ids/suricata/<a href=3D"http://python3-sur=
icata-update_1.3.6.bb" rel=3D"noreferrer" target=3D"_blank">python3-suricat=
a-update_1.3.6.bb</a><br>
<br>
diff --git a/recipes-ids/suricata/<a href=3D"http://python3-suricata-update=
_1.3.6.bb" rel=3D"noreferrer" target=3D"_blank">python3-suricata-update_1.3=
.6.bb</a> b/recipes-ids/suricata/<a href=3D"http://python3-suricata-update_=
1.3.6.bb" rel=3D"noreferrer" target=3D"_blank">python3-suricata-update_1.3.=
6.bb</a><br>
new file mode 100644<br>
index 0000000..cdf2faa<br>
--- /dev/null<br>
+++ b/recipes-ids/suricata/<a href=3D"http://python3-suricata-update_1.3.6.=
bb" rel=3D"noreferrer" target=3D"_blank">python3-suricata-update_1.3.6.bb</=
a><br>
@@ -0,0 +1,15 @@<br>
+SUMMARY =3D &quot;The tool for updating your Suricata rules&quot;<br>
+HOMEPAGE =3D &quot;<a href=3D"http://suricata-ids.org/" rel=3D"noreferrer"=
 target=3D"_blank">http://suricata-ids.org/</a>&quot;<br>
+SECTION =3D &quot;security Monitor/Admin&quot;<br>
+LICENSE =3D &quot;GPL-2.0-only&quot;<br>
+<br>
+LIC_FILES_CHKSUM =3D &quot;file://LICENSE;beginline=3D1;endline=3D2;md5=3D=
c70d8d3310941dcdfcd1e02800a1f548&quot;<br>
+<br>
+SRCREV =3D &quot;f76a61bdee69961537585a1036c4294da28495a5&quot;<br>
+SRC_URI =3D &quot;git://<a href=3D"http://github.com/OISF/suricata-update;=
protocol=3Dhttps;branch=3Dmaster" rel=3D"noreferrer" target=3D"_blank">gith=
ub.com/OISF/suricata-update;protocol=3Dhttps;branch=3Dmaster</a>&quot;<br>
+<br>
+inherit python3native python3targetconfig setuptools3<br>
+<br>
+RDEPENDS:${PN} =3D &quot;python3-pyyaml python3-logging python3-compressio=
n python3-shell&quot;<br>
+<br>
+BBCLASSEXTEND =3D &quot;native nativesdk&quot;<br>
</blockquote></div>

--0000000000000c28e7063ffd1296--

