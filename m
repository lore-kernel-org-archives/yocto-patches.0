Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA1BCD5BC9
	for <webhook@archiver.kernel.org>; Mon, 25 May 2026 15:59:09 +0000 (UTC)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18798.1779724742915774102
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 25 May 2026 08:59:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=Lmzy4pdc;
 spf=pass (domain: gmail.com, ip: 209.85.219.51, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8c9166b26b4so115508636d6.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 25 May 2026 08:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779724742; x=1780329542; darn=lists.yoctoproject.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UM9M9nOrNWMJBqLdJNBTrZ3YpqbZumjLtAFNJ5gsnQI=;
        b=Lmzy4pdccLg+/Tkm42m/D/eKhr95CiVofNCJb8jLCbau9PJNmplQ+30cNXZ5Q1qSqQ
         ftCEPxRn+QUw+e+t27FgPemCUphxZqe3cQKN5Ala4lVg0qbLCp0NMY3bFI4dijgAqkvH
         8QkT6fqmIMoZ8JjfnTeHqBALtS+3/jhnqpWhSOzx5peU0/tTzAzfPS7sk86Bwj/6b4CA
         +VGxONRQXLWp+HCEqa3tPRVGKFRak46R9AFf4HK65aR0vCWgE0SNt5g3ppiUm41TUcX/
         Mtn9iH20apDTWSvrtVeH389QnFKa7a07fRnugGlVKLfyx+EIQosN8HVTFwplxdrfHNMO
         fwJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779724742; x=1780329542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UM9M9nOrNWMJBqLdJNBTrZ3YpqbZumjLtAFNJ5gsnQI=;
        b=H/gzNT3bOpdAvqyZ4Lp8S6dj4TNDfuNdavGgQdnpGWxURK8iRHFfCHFpy1noMVqtRO
         0026cP5A1v2T/BaXEbK9gm702vm1x9GbXx9f4lo9o8q4rjKxqQv4qcXHznF5vrCorq0R
         rsek0tY1EENFpYZ+6aGq8MlmsxR8TkpJAmdPMCoZUfH8RhdBu7PZJqQsqnguTlK+PAvA
         aG65cYRrOKaw9bK/4160Jd1rN02gqp3GunaW5OFxNI0CHDHK0hdQjLGz+jHbCoOqNEOX
         p3ars3fipR+mMeNiZzEkAJfJlg45DYPG91GjTUoC7NbHrt2NhQxrZik0PZvJj4ZlpYTG
         14uw==
X-Gm-Message-State: AOJu0YyN6/qlI0sFGQ4+qJbDpsJ/5iaNk3hG+IcrNpKcOD/sAwUZShgK
	YlMmAaHHykNFG7j3JviApGxCKfFeslHTaswzqp1YvfV7lUmLkBSHmhiUCkRBhg==
X-Gm-Gg: Acq92OEE63Q3Tu800McQr9bFNyOdFo7EwBYBu8oOoi8d2a3Vn6Pv3pnIBJyDYXoQeHU
	nKdrosO8mPAiKuMqrij4F/x0WINL2xu6jbBDsgbNjVmaUfcRDlO9a8T+Ee79s8uKoexZ1/jJIez
	PR6CIDeIx8gYDym+Muu8nsRIBZvuERJb1Jl7P8gM+AzfLTRN2IQEireoNYJVAsm0hh9EBHGabAu
	kqVnfW1DDRMmDjpvd2JSo+FDKvuQ20IbJ8mKbRkp6pjJA8ANv53WiN/jRN/anzgUldEx7vCSWAb
	+8/zTeJ5VQwS8/BM8sXbWtIxjD4xMbSEjHElR5KUwjU+QoGpJplQNN1jwADgx+Gawrlg7e3r4RG
	2nEJ49B0/Ne+0FcCEyfhivAgP3nmJmnOtokrI0Cp1QwU6FDplL6KMe3shYqx5EP5Y8nr21hiCcM
	He/5GBLHislDbsv8+BUon/n1Rv3ICA7brTlygpVVxQq6qr7jnoz1XLfTDl9wtPakExfbITN0Pzo
	itm
X-Received: by 2002:a05:6214:500c:b0:8aa:a025:78e3 with SMTP id 6a1803df08f44-8cc7b4ec374mr247691276d6.6.1779724741661;
        Mon, 25 May 2026 08:59:01 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc80decd3csm112516146d6.12.2026.05.25.08.59.00
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 08:59:00 -0700 (PDT)
Date: Mon, 25 May 2026 11:58:59 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [wic][PATCH] partition.py: restore selinux label
 for fstab
Message-ID: <ahRxw3S7fQd9u4Ei@localhost.localdomain>
References: <20260417031417.583413-1-yi.zhao@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260417031417.583413-1-yi.zhao@windriver.com>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 25 May 2026 15:59:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4043

Hi,

Thanks for the patch.

On Fri 2026-04-17 @ 11:14:17 AM, Yi Zhao via lists.yoctoproject.org wrote:
> When SELinux is enabled, all files within a wic image retain their
> SELinux labels except for /etc/fstab, which is replaced by a newly
> generated one during the build, causing its extended attributes to be
> lost.
> 
> Restore the SELinux context on the new fstab using debugfs ea_get and
> ea_set commands, ensuring all files are correctly labeled at build time
> and avoiding a full SELinux relabel on first boot.
> 
> Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
> ---
>  src/wic/partition.py | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/src/wic/partition.py b/src/wic/partition.py
> index 435d31d..506ef2b 100644
> --- a/src/wic/partition.py
> +++ b/src/wic/partition.py
> @@ -362,10 +362,21 @@ class Partition():
>  
>          if self.updated_fstab_path and self.has_fstab and not self.no_fstab_update:
>              debugfs_script_path = os.path.join(cr_workdir, "debugfs_script")
> +            fstab_label_path = os.path.join(cr_workdir, "fstab.selinuxlabel")
> +            with open(debugfs_script_path, "w") as f:
> +                f.write("cd etc\n")
> +                # Retrieve fstab selinux label
> +                f.write("ea_get -f %s fstab security.selinux\n" % (fstab_label_path))
> +            debugfs_cmd = "debugfs -w -f %s %s" % (debugfs_script_path, rootfs)
> +            exec_native_cmd(debugfs_cmd, native_sysroot)

This debugfs call is only *reading* an xattr (ea_get), so it does not
need the -w flag; please remove.

Also, if the rootfs is non-SELinux, this call will print "xattr
security.selinux not found" or something like that which ends up in the
wic log. Can you arrange so this doesn't happen otherwise users will be
confused by this line appearing in the log and might waste time trying
to figure out why.

> +
>              with open(debugfs_script_path, "w") as f:
>                  f.write("cd etc\n")
>                  f.write("rm fstab\n")
>                  f.write("write %s fstab\n" % (self.updated_fstab_path))
> +                if os.path.isfile(fstab_label_path) and os.path.getsize(fstab_label_path) > 0:
> +                    # Restore fstab selinux label
> +                    f.write("ea_set -f %s fstab security.selinux\n" % (fstab_label_path))
>              debugfs_cmd = "debugfs -w -f %s %s" % (debugfs_script_path, rootfs)
>              exec_native_cmd(debugfs_cmd, native_sysroot)
>  
> -- 
> 2.43.0
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#3726): https://lists.yoctoproject.org/g/yocto-patches/message/3726
> Mute This Topic: https://lists.yoctoproject.org/mt/118870524/900817
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13168745/900817/63955952/xyzzy [twoerner@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 

