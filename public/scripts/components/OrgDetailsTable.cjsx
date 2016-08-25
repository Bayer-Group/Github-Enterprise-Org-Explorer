React = require 'react'
bytes = require 'bytes'
{Table, TableBody, TableHeader, TableHeaderColumn, TableRow, TableRowColumn} = require 'material-ui/Table'

OrgDetailsTable = ({org}) ->
        <Table selectable={false} style={marginBottom: 10}>
            <TableBody displayRowCheckbox={false} showRowHover={false}>
                {
                    if org.blog
                        <TableRow>
                            <TableRowColumn>URL</TableRowColumn>
                            <TableRowColumn><a href={org.blog}>{org.blog}</a></TableRowColumn>
                        </TableRow>
                }
                {
                    if org.location
                        <TableRow>
                            <TableRowColumn>Location</TableRowColumn>
                            <TableRowColumn>{org.location}</TableRowColumn>
                        </TableRow>
                }
                <TableRow>
                    <TableRowColumn>Repositories</TableRowColumn>
                    <TableRowColumn>
                        <ul style={listStyleType: 'none', padding: 0}>
                            <li>Public: {org.public_repos}</li>
                            <li>Private: {org.owned_private_repos}</li>
                            <li>Total: {org.public_repos + org.owned_private_repos}</li>
                        </ul>
                    </TableRowColumn>
                </TableRow>
                <TableRow>
                    <TableRowColumn>Gists</TableRowColumn>
                    <TableRowColumn>
                        <ul style={listStyleType: 'none', padding: 0}>
                            <li>Public: {org.public_gists}</li>
                            <li>Private: {org.private_gists}</li>
                            <li>Total: {org.public_gists + org.private_gists}</li>
                        </ul>
                    </TableRowColumn>
                </TableRow>
                <TableRow>
                    <TableRowColumn>Disk Usage</TableRowColumn>
                    <TableRowColumn>{bytes (org.disk_usage * 1028), unitSeparator: ' '}</TableRowColumn>
                </TableRow>
            </TableBody>
        </Table>

OrgDetailsTable.prototype.displayName = 'OrgDetailsTable'

module.exports = OrgDetailsTable
