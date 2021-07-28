class Release {

    final List<Asset>? assetList;
    final String? body;
    final bool? pre;
    final String? tagName;

    Release({ this.assetList, this.body, this.pre, this.tagName });

    factory Release.fromJson(Map<String, dynamic> json) {
        return Release(
            assetList: (json['assets'] as List?)?.map((e) => Asset.fromJson(e)).toList(),
            body: json['body'],
            pre: json['prerelease'],
            tagName: json['tag_name'],
        );
    }

}

class Asset {
    
    final String? downloadUrl;
    final String? name;
    final String? state;

    Asset({ this.downloadUrl, this.name, this.state });

    factory Asset.fromJson(Map<String, dynamic> json) {
        return Asset(
            downloadUrl: json['browser_download_url'],
            name: json['name'],
            state: json['state'],
        );
    }

}