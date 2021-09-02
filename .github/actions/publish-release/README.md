# publish-release composite action

This action allows you to set up a release cycle for 
your image without worrying about the hard stuff.

Please see one of the examples in the [workflows directory](../../workflows).

## Inputs

### `image` (*Required*)

The name of the image. This should map to `images/<name>.dockerfile` and 
`images/<name>/` (the directory where the image resources are stored).

### `dry-run` (*Optional*)

Defaults to `false`. If set to anything but false, will build and tag
the image, as well as create the slack notification, but will not
push the release.

### `github-token` (*Required*)

Most of the time you can set this to `${{ secrets.GITHUB_TOKEN }}`, however 
if you want your workflow to trigger another workflow, you should 
supply a personal access token instead. 

This token allows the workflow to publish the new docker image.

### `slack-token` (*Required*)

Set this to `${{ secrets.ACTIONS_SLACK_BOT_TOKEN }}`. This token allows the workflow
to create and update a slack notification canvas.

### `gcloud-token` (*Required*)

Set this to `${{ secrets.GCR_TOKEN }}`. This token allows the notification 
action to update the gcloud datastore.
